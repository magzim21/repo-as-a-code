"""No GitHub workflow in this repo lets a Terraform plan file leave the runner.

A saved plan (terraform plan -out=FILE) holds the configuration, a state snapshot and every planned value in plain
text: sensitive attributes and values read by data sources (SSM secrets, provider API keys) included. Anyone who can
read the repo's Actions can download an artifact while it is kept (security incident 2026-10-15). So:
- a job that saves a plan (terraform plan -out) uploads no artifact at all;
- no upload-artifact step anywhere names a plan file (tfplan, *.tfplan, a FILE that some job saves with -out);
- no download-artifact step fetches a plan: tf-apply plans again in its own job and applies that file there.
The workflow templates other repos get from this one (templates/gha/*.tpl, written by repository_files in main.tf)
are checked as well. Run: python3 tests/test_no_plan_artifacts.py (also in the CI tests job)."""
import glob, os, re, sys, tempfile

ARTIFACT = re.compile(r"\buses:\s*actions/(upload|download)-artifact@")
PLAN_OUT = re.compile(r"\bterraform\b[^\n#]*\bplan\b[^\n#]*?\s-out[= ]\s*['\"]?([^\s'\"]+)")
PLAN_NAME = re.compile(r"tfplan|\.plan\b", re.I)


def _indent(line):
    return len(line) - len(line.lstrip(" "))


def jobs(text):
    """{job: [lines]} of the jobs under `jobs:`; comment and blank lines are dropped."""
    out, jobs_ind, job_ind, job = {}, None, None, None
    for line in text.splitlines():
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        ind = _indent(line)
        if jobs_ind is None:
            if re.match(r"^jobs:\s*(#.*)?$", s):
                jobs_ind = ind
            continue
        if ind <= jobs_ind:
            break
        if job_ind is None:
            job_ind = ind
        if ind == job_ind:
            m = re.match(r"^([A-Za-z0-9_-]+):\s*(#.*)?$", s)
            job = m.group(1) if m else None
            if job:
                out[job] = []
            continue
        if job:
            out[job].append(line)
    return out


def steps(lines):
    """The steps of one job, each as its text: a step starts at a `- ` line at the steps' indentation."""
    out, cur, steps_ind, item_ind = [], None, None, None
    for line in lines:
        s, ind = line.strip(), _indent(line)
        if re.match(r"^steps:\s*(#.*)?$", s):
            steps_ind, item_ind, cur = ind, None, None
            continue
        if steps_ind is None:
            continue
        if ind < steps_ind or (ind == steps_ind and not s.startswith("-")):
            steps_ind, cur = None, None
            continue
        if s.startswith("-") and (item_ind is None or ind == item_ind):
            item_ind = ind
            cur = [line]
            out.append(cur)
        elif cur is not None:
            cur.append(line)
    return ["\n".join(c) for c in out]


def problems(text):
    """[(job, reason)] for one workflow's text; empty when no plan file can leave the runner."""
    found = jobs(text)
    if not found:
        return [("-", "no job found under jobs:")]
    saved = {os.path.basename(m.group(1)) for lines in found.values() for m in PLAN_OUT.finditer("\n".join(lines))}
    bad = []
    for job, lines in found.items():
        saves = PLAN_OUT.search("\n".join(lines))
        for step in steps(lines):
            m = ARTIFACT.search(step)
            if not m:
                continue
            kind = m.group(1)
            names = PLAN_NAME.search(step) or any(
                re.search(r"(?<![\w.-])" + re.escape(f) + r"(?![\w.-])", step) for f in saved)
            if kind == "upload" and saves:
                bad.append((job, "saves a terraform plan and uploads an artifact"))
            elif names:
                bad.append((job, f"{kind}s a terraform plan artifact"))
    return bad


OLD = """on: push
jobs:
  tf-plan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Terraform plan
        run: terraform plan -out=tfplan -parallelism=20
      - name: Upload Terraform plan
        uses: actions/upload-artifact@v4
        with:
          name: tfplan
          path: tfplan
  tf-apply:
    needs: tf-plan
    steps:
      - name: Download Terraform plan
        uses: actions/download-artifact@v4
        with:
          name: tfplan
      - run: terraform apply -auto-approve tfplan
"""

NEW = """on: push
jobs:
  tests:
    steps:
      - uses: gitleaks/gitleaks-action@v2
      - uses: actions/upload-artifact@v4
        with:
          name: gitleaks-report
          path: report.sarif
  tf-plan:
    steps:
      # - uses: actions/upload-artifact@v4   (commented out: ignored)
      #   with: {name: tfplan}
      - run: terraform plan -input=false -parallelism=20
  tf-apply:
    steps:
      - name: Plan and apply in this job
        run: |
          terraform plan -input=false -out=tfplan
          terraform apply -auto-approve tfplan
"""


def self_test():
    """The check fails on the old upload/download pattern and on each way around it; passes the new pattern."""
    cases = {
        "old pattern": (OLD, [("tf-plan", "saves a terraform plan and uploads an artifact"),
                              ("tf-apply", "downloads a terraform plan artifact")]),
        "new pattern": (NEW, []),
        "plan with another file name uploaded by another job": (
            "jobs:\n  a:\n    steps:\n      - run: terraform -chdir=tf plan -out plan.bin\n"
            "  b:\n    steps:\n      - uses: actions/upload-artifact@v4\n        with:\n          path: tf/plan.bin\n",
            [("b", "uploads a terraform plan artifact")]),
        "plan saved and any artifact uploaded in the same job": (
            "jobs:\n  a:\n    steps:\n      - run: terraform plan -out=p\n      - run: terraform show -json p > out.json\n"
            "      - uses: actions/upload-artifact@v4\n        with:\n          path: out.json\n",
            [("a", "saves a terraform plan and uploads an artifact")]),
        "tfplan uploaded from a job without terraform": (
            "jobs:\n  a:\n    steps:\n      - uses: actions/upload-artifact@v4\n        with:\n          name: x\n"
            "          path: terraform/tfplan\n", [("a", "uploads a terraform plan artifact")]),
        "document indented by 2": (
            "  on: push\n  jobs:\n    a:\n      steps:\n        - run: terraform plan -out=tfplan\n"
            "        - uses: actions/upload-artifact@v4\n          with:\n            path: build/\n",
            [("a", "saves a terraform plan and uploads an artifact")]),
        "no jobs": ("on: push\nname: x\n", [("-", "no job found under jobs:")]),
    }
    for name, (text, want) in cases.items():
        got = problems(text)
        assert got == want, f"{name}: {got} != {want}"
    with tempfile.TemporaryDirectory() as d:
        p = os.path.join(d, "old.yaml")
        open(p, "w").write(OLD)
        assert not check([p], report=False), "check() passed a workflow that uploads a plan"
    print(f"NP0 the check catches {len(cases) - 1} ways a plan leaves the runner and passes the new pattern ok")


def check(paths, report=True):
    bad = [(os.path.basename(p), j, why) for p in paths for j, why in problems(open(p, encoding="utf-8").read())]
    for f, j, why in bad if report else []:
        print(f"FAIL {f}: job {j}: {why}")
    return not bad


if __name__ == "__main__":
    self_test()
    here = os.path.dirname(os.path.abspath(__file__))
    files = sorted(glob.glob(os.path.join(here, "..", ".github", "workflows", "*.y*ml")))
    files += sorted(glob.glob(os.path.join(here, "..", "templates", "gha", "*.tpl")))
    if not files or not check(files):
        sys.exit(1)
    print(f"NP1 no plan file leaves the runner in {len(files)} workflow file(s) ok")

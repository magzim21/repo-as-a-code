# repo-as-a-code
This repository manages itself as code, and every magzim21 repository.

## New repositories
New repository = new entry in `main.tf` here; never create one in the GitHub UI or with `gh repo create`.
`terraform plan` fails and names every magzim21 repository that is not in `local.repos` (`main.tf`) or a
project module (`projects.tf`) (`guard.tf`, `modules/repo-guard`, tested by `tests/guard.tftest.hcl`). An existing
repository is added with an entry plus an `import` block in `imports.tf`; a temporary exception goes into the
allowlist in `guard.tf` with the link to the task that decides it.

## Github pages
Make sure that CNAME is set in UI (the provider's doc says the second apply is required.)
Re-run GHA pages build workflow **after** CNAME is enabled.

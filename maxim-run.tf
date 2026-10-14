# Max Onyx's personal site on https://maxim.run (repository magzim21/maxim-run, entry in main.tf).
# Vercel builds it from the prod branch with the repo's own vercel.json (build command, output directory).
# Task: https://app.notion.com/p/3f9b399fe9c2818081bdde6254d884f6
#
# The apex is not owned by the codelaw Vercel team, so Vercel asks for a TXT proof of ownership per domain
# (_vercel.maxim.run in projects.tf). The provider does not expose that value
# (https://github.com/vercel/terraform-provider-vercel/issues/199): after the first apply, read it with
# GET https://api.vercel.com/v9/projects/maxim-run/domains/<domain>?slug=codelaw (field verification[].value).

resource "vercel_project" "maxim_run" {
  name = "maxim-run"

  git_repository = {
    type              = "github"
    repo              = "magzim21/${module.repos["maxim-run"].repository.name}"
    production_branch = "prod"
  }

  # Vercel refuses a production branch that does not exist yet: wait until the module has renamed main to prod.
  depends_on = [module.repos["maxim-run"]]
}

resource "vercel_project_domain" "maxim_run_apex" {
  project_id = vercel_project.maxim_run.id
  domain     = "maxim.run"
}

# One address per page: www answers with a 301 to the apex.
resource "vercel_project_domain" "maxim_run_www" {
  project_id           = vercel_project.maxim_run.id
  domain               = "www.maxim.run"
  redirect             = vercel_project_domain.maxim_run_apex.domain
  redirect_status_code = 301
}

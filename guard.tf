# Guard: terraform plan fails when a magzim21 repository exists on GitHub but is
# not managed here (local.repos in main.tf or a project module in projects.tf).
# New repository = new entry in main.tf; never create one in the GitHub UI or with
# `gh repo create`. Task: https://app.notion.com/p/3f4b399fe9c28158b680e1ef06050671

module "repo_guard" {
  source = "./modules/repo-guard"
  owner  = "magzim21"

  managed_names = concat(
    keys(module.repos),
    [
      module.cleaning_landing_page.repository_name,
      module.boat_detailing_landing_page.repository_name,
      module.photography_landing_page.repository_name,
    ],
  )

  # Temporary exceptions: repository name => the task that decides it. Remove an
  # entry when its task lands; an empty map is the goal.
  allowlist = {
    "firefly-iii" = "https://app.notion.com/p/3f4b399fe9c281dcb483fe69d5974471" # fork: delete it or manage it
  }
}

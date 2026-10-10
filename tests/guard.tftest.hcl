# terraform test for modules/repo-guard (used by guard.tf). No credentials: the
# GitHub provider is mocked and the repository list comes from override_data.

mock_provider "github" {}

variables {
  owner         = "magzim21"
  managed_names = ["utilities", "repo-as-a-code", "RPG_game", "cleaning-landing-page"]
  allowlist     = { "firefly-iii" = "https://app.notion.com/p/3f4b399fe9c281dcb483fe69d5974471" }
}

run "unmanaged_repository_fails_the_plan" {
  command = plan
  module {
    source = "./modules/repo-guard"
  }

  override_data {
    target = data.github_repositories.owned
    values = {
      names = ["utilities", "cleaning-landing-page", "firefly-iii", "created-in-the-github-ui"]
    }
  }

  expect_failures = [terraform_data.guard]
}

run "managed_and_allowlisted_repositories_pass" {
  command = plan
  module {
    source = "./modules/repo-guard"
  }

  override_data {
    target = data.github_repositories.owned
    values = {
      names = ["utilities", "repo-as-a-code", "RPG_game", "cleaning-landing-page", "firefly-iii"]
    }
  }

  assert {
    condition     = length(output.unmanaged) == 0
    error_message = "managed repositories were reported as unmanaged: ${join(", ", output.unmanaged)}"
  }
}

run "an_allowlist_entry_is_needed_for_an_unmanaged_fork" {
  command = plan
  module {
    source = "./modules/repo-guard"
  }

  variables {
    allowlist = {}
  }

  override_data {
    target = data.github_repositories.owned
    values = {
      names = ["utilities", "firefly-iii"]
    }
  }

  expect_failures = [terraform_data.guard]
}

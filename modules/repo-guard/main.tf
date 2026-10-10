# Fails terraform plan when an owner's repository exists on GitHub but is not
# managed by this configuration. Used by guard.tf; tested by tests/guard.tftest.hcl.

terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

variable "owner" {
  type        = string
  description = "GitHub user whose repositories must all be managed."
}

variable "managed_names" {
  type        = list(string)
  description = "Repository names managed by this configuration."
}

variable "allowlist" {
  type        = map(string)
  description = "Temporary exceptions: repository name => the task that decides it."
  default     = {}
}

data "github_repositories" "owned" {
  # fork:true includes forks (search leaves them out by default); archived and
  # private repositories are included.
  query            = "user:${var.owner} fork:true"
  include_repo_id  = false
  results_per_page = 100
}

locals {
  unmanaged = sort(tolist(setsubtract(
    toset(data.github_repositories.owned.names),
    toset(concat(var.managed_names, keys(var.allowlist))),
  )))
}

resource "terraform_data" "guard" {
  lifecycle {
    precondition {
      condition     = length(local.unmanaged) == 0
      error_message = "${var.owner} repositories outside repo-as-a-code: ${join(", ", local.unmanaged)}. Add each to local.repos in main.tf with an import block in imports.tf (or to the allowlist in guard.tf with the task that decides it)."
    }
  }
}

output "unmanaged" {
  description = "Repositories on GitHub that are neither managed nor allowlisted."
  value       = local.unmanaged
}

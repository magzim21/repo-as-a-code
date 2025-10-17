module "this" {
  source = "codelawcorp/repository/github"
  # version = "~> 2.0.0"  # It is always recommended to pin the version

  name        = "repo-as-a-code"
  description = "This repository manages itself as code. Also it will manage other repositories in the future."
  visibility  = "public"

  archive_on_destroy = false

  bootstrap_tf_cloud = {
    tf_cloud_organization = "magzim21" # This is example. Replace with your organization name.
    tf_cloud_workspace    = "github"   # This is example. Replace with your workspace name.
    terraform_version     = try(file("${abspath(path.root)}/.terraform-version"), "latest")
    tfe_token             = var.tfe_token
    github_token          = var.github_token
  }
}

variable "tfe_token" {
  description = "Terraform Cloud token"
  type        = string
  sensitive   = true
  # default = null # uncomment after the first apply
  nullable = true
}
variable "github_token" {
  description = "GitHub token"
  type        = string
  sensitive   = true
  # default = null # uncomment after the first apply
  nullable = true
}


# import {
#   to = module.quick_ops.github_repository.this
#   id = "quick-ops"
# }
module "quick_ops" {
  source = "codelawcorp/repository/github"
  # version = "~> 2.0.0"  # It is always recommended to pin the version

  name        = "quick_ops"
  description = "Scripting magic. Like Ansible ad-hoc but with iterm2"
  visibility  = "public"

  archive_on_destroy = true
}



import {
  to = module.obsidian_notes.github_repository.this
  id = "obsidian-notes"
}
module "obsidian_notes" {
  source = "codelawcorp/repository/github"
  # version = "~> 2.0.0"  # It is always recommended to pin the version

  name        = "obsidian-notes"
  description = "Knowldege notes. Aka second brain."

  archive_on_destroy = true
}

import {
  to = module.magzim21.github_repository.this
  id = "magzim21"
}
module "magzim21" {
  source = "codelawcorp/repository/github"
  # version = "~> 2.0.0"  # It is always recommended to pin the version

  name        = "magzim21"
  description = "My bio and links"
  visibility  = "public"

  archive_on_destroy = true
}


import {
  to = module.elk_services.github_repository.this
  id = "elk_services"
}
module "elk_services" {
  source = "codelawcorp/repository/github"
  # version = "~> 2.0.0"  # It is always recommended to pin the version

  name                               = "elk_services"
  description                        = "Scripting magic. Like Ansible ad-hoc but with iterm2"
  archived                           = true
  vulnerability_alerts               = false # must be false for archived repos
  enable_dependabot_security_updates = false
  visibility                         = "public"

  archive_on_destroy = true
}



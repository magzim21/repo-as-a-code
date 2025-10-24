locals {
  repos = [
    {
      name        = "repo-as-a-code"
      description = "This repository manages itself as code. Also it will manage other repositories in the future."
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "elk_services"
      description = "Scripting magic. Like Ansible ad-hoc but with iterm2"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "magzim21"
      description = "My bio and links"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "obsidian-notes"
      description = "Knowldege notes. Aka second brain."
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "quick_ops"
      description = "Scripting magic. Like Ansible ad-hoc but with iterm2"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "quick-ops"
      description = ""
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "job_parser"
      description = "Docker, AWS EB, BeautifulSoup, Selenium, Telegram-bot, psycopg2, logging. Also: chrome, Xpra (virtual display)."
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "Kanban-Board"
      description = "Java Script Advanced ITEA final exam"
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "terragrunt-sync"
      description = ""
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "ship-fast-ts"
      description = "The NextJs boilerplate to ship. FAST. ⚡️"
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "english-new"
      description = ""
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "template"
      description = "This is a repo template 👨🏼‍🔬"
      visibility  = "public"
      archived    = false
      is_template = true
      branches = [
        {
          name = "gh-pages"
        },
        {
          name = "wtf"
        },
        {
          name = "prod"
        }
      ]
      pages = { // GitHub provider issue: pages branch must exist at applytime / bootstrap problem
        source = {
          branch = "gh-pages"
          path   = "/"
        }
      }

    },
    {
      name        = "crypto-seed-phrase-generator"
      description = ""
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "dotfiles"
      description = ""
      visibility  = "private"
      archived    = false
      is_template = false
    },
    {
      name        = "safedial"
      description = "A password checker CLI tool ☘️"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "elevate-sec"
      description = ""
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "magz8s"
      description = "EKS installation with best practices"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "kubespray-lite"
      description = "aws ec2, terraform, ansible, kubernetes"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name                               = "magzim21.github.io"
      description                        = "Personal website"
      visibility                         = "public"
      archived                           = false
      is_template                        = false
      enable_dependabot_security_updates = false
      branches = [
        {
          name = "gh-pages"
        }
      ]
      pages = { // GitHub provider issue: pages branch must exist at applytime / bootstrap problem
        source = {
          branch = "gh-pages"
          path   = "/"
        }
      }
    },
    {
      name        = "aws_terraform"
      description = "ASG(EC2) + ELB"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "Ansible-gather-information"
      description = "This Ansible role use useful for those freshmans who just came to project and not familiar with infrastructure etc."
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "ansible_change_hostnames"
      description = "ANSIBLE batch rename hostnames. It works with systemd, but can easily be adopted for init systems."
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "zabbix_agents_ansible"
      description = "This is a simple playbook for mass installing zabbix agents. "
      visibility  = "public"
      archived    = false
      is_template = false
    },
    {
      name        = "docker-zabbix-mysql"
      description = ""
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "OOP-csv-editor"
      description = "Console CSV editor with OOP"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "Django-Flowers-Shop"
      description = "ITEA course work. I have got RED diploma on it."
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "PHP-MySQL-JS_Payroll_System"
      description = "epam test task"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "Rolling-dice-game"
      description = "Simple console gambling game"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "Parking-app"
      description = "OOP practice with python"
      visibility  = "public"
      archived    = true
      is_template = false
    },
    {
      name        = "Registration-form"
      description = "training task"
      visibility  = "public"
      archived    = true
      is_template = false
    },
  ]
}
module "repos" {
  for_each = { for repo in local.repos : repo.name => repo }

  # Swap sources. These docs are autogenerated.
  source = "codelawcorp/repository/github"
  # version = "~> 2.0.0" # It is always recommended to pin version

  name        = try(each.value.name, null)
  description = try(each.value.description, null)
  visibility  = try(each.value.visibility, null)


  archived    = try(each.value.archived, null)
  is_template = try(each.value.is_template, null)

  homepage_url = try(each.value.homepage_url, null)
  # topics       = try(each.value.topics, [])
  topics = []

  has_projects    = try(each.value.has_projects, null)
  has_wiki        = try(each.value.has_wiki, null)
  has_downloads   = try(each.value.has_downloads, null)
  has_discussions = try(each.value.has_discussions, null)

  # Merge settings
  allow_auto_merge       = try(each.value.allow_auto_merge, null)
  allow_merge_commit     = try(each.value.allow_merge_commit, null)
  allow_squash_merge     = try(each.value.allow_squash_merge, null)
  allow_rebase_merge     = try(each.value.allow_rebase_merge, null)
  delete_branch_on_merge = try(each.value.delete_branch_on_merge, null)

  merge_commit_title          = try(each.value.merge_commit_title, null)
  merge_commit_message        = try(each.value.merge_commit_message, null)
  squash_merge_commit_title   = try(each.value.squash_merge_commit_title, null)
  squash_merge_commit_message = try(each.value.squash_merge_commit_message, null)




  # Template configuration (if using a template repository)
  template = try(each.value.template, null)


  default_branch    = try(each.value.default_branch, null)
  branches          = try(each.value.branches, null)
  custom_properties = []


  deploy_keys = []

  #   # GitHub Pages configuration (optional)
  pages = try(each.value.pages, null)

  environments = [
  ]

  actions_variables = [
    # {
    #   name  = "TEST_VAR"
    #   value = "true"
    # }
  ]

  actions_secrets = [
    # {
    #   name  = "DEPLOY_TOKEN"
    #   value = "secret-token-value"
    # }
  ]

  # This also automatically enables vulnerability_alerts
  enable_dependabot_security_updates = try(each.value.enable_dependabot_security_updates, null)

  # Use the dedicated repository_topics resource for topic management
  use_repository_topics_resource = try(each.value.use_repository_topics_resource, null)

  # Configure webhooks for the repository
  webhooks = [
    # {
    #   url          = "https://jenkins.example.com/github-webhook/"
    #   content_type = "json"
    #   events       = ["push", "pull_request"]
    # }
  ]





  users = [
    # {
    #   username   = "magzim21"
    #   permission = "admin"
    # }
  ]

  teams = [
    # {
    #   team_id    = "your-org/admin-team"
    #   permission = "admin"
    # }
  ]

  # Add GitHub repository files
  repository_files = {

  }

  # Add issue labels
  issue_label = [
  ]
  # Create an autolink reference
  autolink_references = [
  ]

  # gitignore_template = "Python"
  # license_template   = "mit"

  # actions_repository_permissions = {
  #   allowed_actions = "selected"
  #   enabled         = true
  #   allowed_actions_config = {
  #     github_owned_allowed = true
  #     patterns_allowed     = ["actions/*"]
  #     verified_allowed     = true
  #   }
  # }

  # Projects are not supported by this module.
  # 410 Projects (classic) has been deprecated in favor of the new Projects experience. []
}



variable "zone_name" {
  type        = string
  description = "Route53 zone name."
  default     = "maxim.run"
}

variable "vercel" {
  type = object({
    cname                  = string
    txt_verification       = string
    resend_api_key         = string
    resend_dkim_public_key = optional(string)
    resend_ses_region      = optional(string)
    resend_spf_value       = optional(string)
    resend_dmarc_value     = optional(string)
  })
  description = "Vercel settings."
  nullable    = false
  default = {
    cname                  = null
    txt_verification       = null
    resend_api_key         = null
    resend_dkim_public_key = null
    resend_ses_region      = "us-east-1"
    resend_spf_value       = "v=spf1 include:amazonses.com ~all"
    resend_dmarc_value     = "v=DMARC1; p=none;"
  }
}

variable "name" {
  type        = string
  description = "GitHub repository name."
}

variable "description" {
  type        = string
  description = "Repository description."
  nullable    = true
  default     = null
}

variable "visibility" {
  type        = string
  description = "Repository visibility: public, private, or internal."
}

variable "homepage_url" {
  type        = string
  description = "Homepage URL; if unset, derived from Pages CNAME or DNS when Pages are enabled."
  nullable    = true
  default     = null
}

variable "pages" {
  type = object({
    build_type               = optional(string)
    cname                    = optional(string)
    do_not_create_index_html = optional(bool)
    source = optional(object({
      branch = optional(string)
      path   = optional(string)
    }))
  })
  description = "GitHub Pages settings; set to null to disable Pages."
  nullable    = true
  default     = null
}

variable "fork" {
  type        = bool
  description = "Whether the repository is a fork."
  nullable    = true
  default     = null
}

variable "source_owner" {
  type        = string
  description = "Source repository owner when forking or using a template."
  nullable    = true
  default     = null
}

variable "source_repo" {
  type        = string
  description = "Source repository name when forking or using a template."
  nullable    = true
  default     = null
}

variable "archived" {
  type        = bool
  description = "Whether the repository is archived."
  nullable    = true
  default     = null
}

variable "is_template" {
  type        = bool
  description = "Whether the repository is a template repository."
  nullable    = true
  default     = null
}

variable "topics" {
  type        = list(string)
  description = "GitHub topic labels for the repository."
  default     = []
}

variable "has_projects" {
  type        = bool
  description = "Enable GitHub Projects (classic) on the repository."
  nullable    = true
  default     = null
}

variable "has_wiki" {
  type        = bool
  description = "Enable the wiki."
  nullable    = true
  default     = null
}

variable "has_discussions" {
  type        = bool
  description = "Enable GitHub Discussions."
  nullable    = true
  default     = null
}

variable "allow_auto_merge" {
  type        = bool
  description = "Allow auto-merge for pull requests."
  nullable    = true
  default     = null
}

variable "allow_merge_commit" {
  type        = bool
  description = "Allow merging with merge commits."
  nullable    = true
  default     = null
}

variable "allow_squash_merge" {
  type        = bool
  description = "Allow squash merges."
  nullable    = true
  default     = null
}

variable "allow_rebase_merge" {
  type        = bool
  description = "Allow rebase merges."
  nullable    = true
  default     = null
}

variable "delete_branch_on_merge" {
  type        = bool
  description = "Automatically delete head branches after merge."
  nullable    = true
  default     = null
}

variable "merge_commit_title" {
  type        = string
  description = "Default title for merge commits (GitHub API enum)."
  nullable    = true
  default     = null
}

variable "merge_commit_message" {
  type        = string
  description = "Default message for merge commits (GitHub API enum)."
  nullable    = true
  default     = null
}

variable "squash_merge_commit_title" {
  type        = string
  description = "Default title for squash merge commits (GitHub API enum)."
  nullable    = true
  default     = null
}

variable "squash_merge_commit_message" {
  type        = string
  description = "Default message for squash merge commits (GitHub API enum)."
  nullable    = true
  default     = null
}

variable "template" {
  type        = any
  description = "Template repository configuration for codelawcorp/repository."
  nullable    = true
  default     = null
}

variable "default_branch" {
  type        = string
  description = "Default branch name."
  nullable    = true
  default     = "prod"
}

variable "branches" {
  type        = any
  description = "Additional branch protection and settings passed to the repository module."
  nullable    = true
  default     = null
}

variable "environments" {
  type        = any
  description = "GitHub Actions environments configuration."
  nullable    = true
  default     = null
}

variable "actions_variables" {
  type        = any
  description = "Repository Actions variables."
  nullable    = true
  default     = null
}

variable "actions_secrets" {
  type        = any
  description = "Repository Actions secrets."
  nullable    = true
  default     = null
  sensitive   = true
}

variable "webhooks" {
  type        = any
  description = "Repository webhooks configuration."
  nullable    = true
  default     = null
}

variable "users" {
  type        = any
  description = "Direct collaborator users configuration."
  nullable    = true
  default     = null
}

variable "teams" {
  type        = any
  description = "Team access configuration."
  nullable    = true
  default     = null
}

variable "repository_files" {
  type        = map(any)
  description = "Extra repository files (path -> attributes) merged with generated index.html when applicable."
  default     = {}
}

variable "issue_labels" {
  type        = list(any)
  description = "Issue labels to create on the repository."
  default     = []
}

variable "archive_on_destroy" {
  type        = bool
  description = "Whether to archive the repo when the resource is destroyed."
  nullable    = true
  default     = null
}

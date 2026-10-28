terraform {
  backend "s3" {
    # Varables not allowed in backend block
    bucket = "terraform-state-249446252531-repo-as-a-code" # module.terraform_state_bucket.s3_bucket_id

    key          = "repo-as-a-code.tfstate"
    region       = "ca-central-1"
    encrypt      = true
    use_lockfile = true
  }
}

# https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws
data "aws_caller_identity" "current" {}


module "terraform_state_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.9.1"

  # The name follows the folder name: plan only from a folder named repo-as-a-code (a worktree goes to
  # .claude/worktrees/<topic>/repo-as-a-code). From any other folder the plan replaces this state bucket (2026-10-27).
  # The repository's name, never the checkout folder's: a worktree in .claude/worktrees/<topic> would plan to
  # replace this bucket, which holds every state of this repository.
  bucket        = "terraform-state-${data.aws_caller_identity.current.account_id}-repo-as-a-code"
  force_destroy = false

  versioning = {
    status = true
  }

  server_side_encryption_configuration = {
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}


terraform {
  backend "s3" {
    # Varables not allowed in backend block
    bucket = "terraform-state-249446252531-repo-as-a-code" # module.terraform_state_bucket.s3_bucket_id

    key          = "terraform.tfstate"
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

  bucket        = "terraform-state-${data.aws_caller_identity.current.account_id}-${basename(abspath(path.root))}"
  force_destroy = false

  versioning = {
    status = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}


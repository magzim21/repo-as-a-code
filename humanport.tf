# Humanport: the human-mcp site on https://humanport.dev (repository magzim21/human-mcp, entry in main.tf).
# Vercel builds it from the prod branch with the repo's own vercel.json, like maxim-run.tf.
# Task: https://app.notion.com/p/408b399fe9c28189824bde579981bff5 (humanport.dev meets the new-project playbook).
#
# The domain: Max registered humanport.dev on 2026-10-29 with Amazon Registrar (RDAP), outside this AWS account
# (249446252531 holds no such registration). The hosted zone lives here all the same, next to maxim.run, so the
# records are one Terraform with the Vercel project; the registration's name servers are pointed at this zone once,
# from the account that holds it (task "Point humanport.dev name servers at the personal hosted zone"). Done on
# 2026-11-01: the registration (codelawcorp account) carries this zone's name servers; its DS record (DNSSEC below) is
# published at the registrar from that account with aws route53domains associate-delegation-signer-to-domain, since
# the aws_route53domains_delegation_signer_record resource would need the registration in this account.

resource "aws_route53_zone" "humanport" {
  name    = "humanport.dev"
  comment = "humanport.dev: magzim21/human-mcp on Vercel. Managed by Terraform (magzim21/repo-as-a-code humanport.tf)"
}

# The four name servers the registrar must carry (the delegation task reads them here).
output "humanport_name_servers" {
  value = aws_route53_zone.humanport.name_servers
}

resource "vercel_project" "humanport" {
  name = "human-mcp"

  git_repository = {
    type              = "github"
    repo              = "magzim21/${module.repos["human-mcp"].repository.name}"
    production_branch = "prod"
  }
}

resource "vercel_project_domain" "humanport_apex" {
  project_id = vercel_project.humanport.id
  domain     = aws_route53_zone.humanport.name
}

# One address per page: www answers with a 301 to the apex.
resource "vercel_project_domain" "humanport_www" {
  project_id           = vercel_project.humanport.id
  domain               = "www.${aws_route53_zone.humanport.name}"
  redirect             = vercel_project_domain.humanport_apex.domain
  redirect_status_code = 301
}

# DNS: the apex goes to Vercel's apex address, www to Vercel's CNAME target.
resource "aws_route53_record" "humanport_apex" {
  zone_id = aws_route53_zone.humanport.zone_id
  name    = aws_route53_zone.humanport.name
  type    = "A"
  ttl     = "300"
  records = ["76.76.21.21"]
}

resource "aws_route53_record" "humanport_www" {
  zone_id = aws_route53_zone.humanport.zone_id
  name    = "www.${aws_route53_zone.humanport.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["cname.vercel-dns.com"]
}

# Datadog RUM of https://humanport.dev ("every site of Max has Datadog RUM", Max, 2026-10-27). The site loads it only
# after the visitor's analytics consent (magzim21/human-mcp src/rum.js) and its privacy page names Datadog.
# RUM data only, 30 days: the privacy page says so.
resource "datadog_rum_application" "humanport" {
  name                              = "humanport.dev"
  type                              = "browser"
  rum_event_processing_state        = "ALL"
  product_analytics_retention_state = "NONE"
}

# Read by magzim21/human-mcp scripts/build.mjs at build time and written into its rum.js; without both no page
# loads RUM. Not sensitive: every visitor's browser gets them. Production only, so preview builds send nothing.
resource "vercel_project_environment_variables" "humanport" {
  project_id = vercel_project.humanport.id
  variables = [
    {
      key       = "DD_RUM_APPLICATION_ID"
      value     = datadog_rum_application.humanport.id
      target    = ["production"]
      sensitive = false
    },
    {
      key       = "DD_RUM_CLIENT_TOKEN"
      value     = datadog_rum_application.humanport.client_token
      target    = ["production"]
      sensitive = false
    },
  ]
}

# Uptime: an HTTP check of the apex every 30 minutes from Canada, alerting Slack like the project module does.
# Live since the registrar points the domain at the zone above (2026-11-01).
resource "datadog_synthetics_test" "humanport" {
  name      = "humanport.dev"
  type      = "api"
  subtype   = "http"
  status    = "live"
  message   = "Notify @slack-codelawcorp-alerts"
  locations = ["aws:ca-central-1"]
  tags      = ["env:prod", "project:humanport"]

  request_definition {
    method = "GET"
    url    = "https://${aws_route53_zone.humanport.name}"
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  options_list {
    tick_every = 1800
    retry {
      count    = 2
      interval = 300
    }
    monitor_options {
      renotify_interval = 120
    }
  }
}

# DNSSEC: KMS key (us-east-1) -> key-signing key -> zone signing. The DS record at the registrar is published from the
# account that holds the registration (see the note at the top), so no aws_route53domains_delegation_signer_record here.
resource "aws_kms_key" "humanport_dnssec" {
  provider = aws.us_east_1

  description              = "DNSSEC key-signing key for humanport.dev"
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  deletion_window_in_days  = 7

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Allow Route 53 DNSSEC Service"
        Effect    = "Allow"
        Principal = { Service = "dnssec-route53.amazonaws.com" }
        Action    = ["kms:DescribeKey", "kms:GetPublicKey", "kms:Sign", "kms:Verify"]
        Resource  = "*"
        Condition = {
          StringEquals = { "aws:SourceAccount" = data.aws_caller_identity.current.account_id }
          ArnLike      = { "aws:SourceArn" = "arn:aws:route53:::hostedzone/*" }
        }
      },
      {
        Sid       = "Allow Route 53 DNSSEC Service to CreateGrant"
        Effect    = "Allow"
        Principal = { Service = "dnssec-route53.amazonaws.com" }
        Action    = "kms:CreateGrant"
        Resource  = "*"
        Condition = {
          Bool = { "kms:GrantIsForAWSResource" = "true" }
        }
      },
      {
        Sid       = "Enable IAM User Permissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      },
    ]
  })
}

resource "aws_kms_alias" "humanport_dnssec" {
  provider      = aws.us_east_1
  name          = "alias/dnssec-humanport-dev"
  target_key_id = aws_kms_key.humanport_dnssec.key_id
}

resource "aws_route53_key_signing_key" "humanport" {
  hosted_zone_id             = aws_route53_zone.humanport.zone_id
  key_management_service_arn = aws_kms_key.humanport_dnssec.arn
  name                       = "humanport_dev"
}

resource "aws_route53_hosted_zone_dnssec" "humanport" {
  hosted_zone_id = aws_route53_key_signing_key.humanport.hosted_zone_id
}

# The delegation task reads these to publish the DS record at the registrar.
output "humanport_ksk" {
  value = {
    algorithm  = aws_route53_key_signing_key.humanport.signing_algorithm_type
    flags      = aws_route53_key_signing_key.humanport.flag
    public_key = aws_route53_key_signing_key.humanport.public_key
    ds_record  = aws_route53_key_signing_key.humanport.ds_record
  }
}

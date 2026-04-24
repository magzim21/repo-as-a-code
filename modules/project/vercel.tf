
resource "vercel_project" "this" {
  name = var.name

  automatically_expose_system_environment_variables = true
  directory_listing                                 = true

  git_comments = {
    on_commit       = true
    on_pull_request = true
  }

  git_repository = {
    type              = "github"
    repo              = "magzim21/${module.gh_repository.repository.name}" # Requires PRO plan if this repo belongs to git organization
    production_branch = var.default_branch
  }
}

# Up to date it is not possible to get verification records from this resource - https://github.com/vercel/terraform-provider-vercel/issues/199
resource "vercel_project_domain" "this" {
  project_id = vercel_project.this.id
  domain     = try(var.vercel.cname, local.domain_name)
  # git_branch = var.default_branch # with this enabled, the project is not deployed to production.
}

resource "vercel_deployment" "this_prod" {
  project_id  = vercel_project.this.id
  production  = true
  ref         = var.default_branch
  environment = {}
}


resource "vercel_project_environment_variables" "this" {
  project_id = vercel_project.this.id
  variables = [
    {
      key       = "RESEND_API_KEY"
      value     = var.vercel.resend_api_key
      target    = ["production"]
      sensitive = true
    },
    {
      key       = "RESEND_API_KEY"
      value     = var.vercel.resend_api_key
      target    = ["preview", "development"]
      sensitive = false # can't be sensitive for development environment
    },
    {
      key       = "BOOKING_EMAIL_FROM"
      value     = "Island Drift Detailing <hello@booking.maxim.run>"
      target    = ["production", "preview", "development"]
      sensitive = false
    },
    {
      key       = "BOOKING_EMAIL_TO"
      value     = "book@maxim.run"
      target    = ["production", "preview", "development"]
      sensitive = false
    },

  ]
}

# Example Usage (Synthetics API test)
# Create a new Datadog Synthetics API/HTTP test on https://www.example.org
# resource "datadog_synthetics_test" "this" {
#   name      = "An Uptime test on ${vercel_project_domain.this.domain}"
#   type      = "api"
#   subtype   = "http"
#   status    = "live"
#   message   = "Notify @slack-codelawcorp-alerts"
#   locations = ["aws:eu-central-1", "aws:ca-central-1"]
#   tags      = ["env:prod", ]

#   request_definition {
#     method = "GET"
#     url    = "https://${vercel_project_domain.this.domain}"
#   }

#   # request_headers = {
#   #   Content-Type = "application/json"
#   # }

#   assertion {
#     type     = "statusCode"
#     operator = "is"
#     target   = "200"
#   }

#   options_list {
#     tick_every = 3600
#     retry {
#       count    = 2
#       interval = 1800
#     }
#     monitor_options {
#       renotify_interval = 1800
#     }
#   }
# }



# # Create Route53 A record for Vercel
# resource "aws_route53_record" "this" {
#   zone_id = data.aws_route53_zone.this.zone_id
#   name    = vercel_project_domain.this.domain
#   type    = "A"
#   ttl     = "300"
#   records = ["76.76.21.21"]
# }

# Create Route53 CNAME record for Vercel
# Not allowed at apex
# resource "aws_route53_record" "this_cname" {
#   zone_id = data.aws_route53_zone.this.zone_id
#   name    = vercel_project_domain.this.domain
#   type    = "CNAME"
#   ttl     = "300"
#   records = ["cname.vercel-dns.com"]
# }

# # # Create Route53 CAA record for Let's Encrypt
# resource "aws_route53_record" "this_caa" {
#   zone_id = data.aws_route53_zone.this.zone_id
#   name    = vercel_project_domain.this.domain
#   type    = "CAA"
#   ttl     = "300"
#   records = ["0 issue \"letsencrypt.org\""]
# }


# resource "datadog_rum_application" "this" { # todo pass outputs to landing page github repo or vercel project variable when bundler is used
#   name = "landing-page"
#   type = "browser"
# }


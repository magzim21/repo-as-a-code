# Max Onyx's personal site on https://maxim.run (repository magzim21/maxim-run, entry in main.tf).
# Vercel builds it from the prod branch with the repo's own vercel.json (build command, output directory).
# Task: https://app.notion.com/p/3f9b399fe9c2818081bdde6254d884f6
#
# The apex is not owned by the codelaw Vercel team, so Vercel asks for a TXT proof of ownership per domain
# (_vercel.maxim.run in projects.tf). The provider does not expose that value
# (https://github.com/vercel/terraform-provider-vercel/issues/199): after the first apply, read it with
# GET https://api.vercel.com/v9/projects/maxim-run/domains/<domain>?slug=codelaw (field verification[].value).

resource "vercel_project" "maxim_run" {
  name = "maxim-run"

  git_repository = {
    type              = "github"
    repo              = "magzim21/${module.repos["maxim-run"].repository.name}"
    production_branch = "prod"
  }

  # Vercel refuses a production branch that does not exist yet: wait until the module has renamed main to prod.
  depends_on = [module.repos["maxim-run"]]
}

resource "vercel_project_domain" "maxim_run_apex" {
  project_id = vercel_project.maxim_run.id
  domain     = "maxim.run"
}

# One address per page: www answers with a 301 to the apex.
resource "vercel_project_domain" "maxim_run_www" {
  project_id           = vercel_project.maxim_run.id
  domain               = "www.maxim.run"
  redirect             = vercel_project_domain.maxim_run_apex.domain
  redirect_status_code = 301
}

# DNS: the apex goes to Vercel (it served the GitHub Pages placeholder of magzim21.github.io until 2026-10-13).
moved {
  from = aws_route53_record.this_a
  to   = aws_route53_record.maxim_run_apex
}

resource "aws_route53_record" "maxim_run_apex" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "A"
  ttl     = "300"
  records = ["76.76.21.21"] # Vercel's apex address
}

# The GitHub Pages IPv6 addresses of the old site go away with it (Vercel serves the apex over IPv4).
removed {
  from = aws_route53_record.this_aaaa
  lifecycle {
    destroy = true
  }
}

# www was a hand-made CNAME to cname.super.so (an old Notion-site host); adopted here and pointed at Vercel,
# which answers it with a 301 to the apex (vercel_project_domain.maxim_run_www).
import {
  to = aws_route53_record.maxim_run_www
  id = "${data.aws_route53_zone.this.zone_id}_www.${data.aws_route53_zone.this.name}_CNAME"
}

resource "aws_route53_record" "maxim_run_www" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "www.${data.aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["cname.vercel-dns.com"]
}

# Datadog RUM of https://maxim.run (task https://app.notion.com/p/407b399fe9c281e38c30dba4cb517c6d; "every site of
# Max has Datadog RUM", Max, 2026-10-27). The site loads it only after the visitor's analytics consent
# (magzim21/maxim-run src/rum.js) and its privacy page names Datadog. RUM data only, 30 days: the privacy page says so.
resource "datadog_rum_application" "maxim_run" {
  name                              = "maxim.run"
  type                              = "browser"
  rum_event_processing_state        = "ALL"
  product_analytics_retention_state = "NONE"
}

# Read by magzim21/maxim-run scripts/build.mjs at build time and written into its rum.js; without both no page
# loads RUM. Not sensitive: every visitor's browser gets them. Production only, so preview builds send nothing.
resource "vercel_project_environment_variables" "maxim_run" {
  project_id = vercel_project.maxim_run.id
  variables = [
    {
      key       = "DD_RUM_APPLICATION_ID"
      value     = datadog_rum_application.maxim_run.id
      target    = ["production"]
      sensitive = false
    },
    {
      key       = "DD_RUM_CLIENT_TOKEN"
      value     = datadog_rum_application.maxim_run.client_token
      target    = ["production"]
      sensitive = false
    },
  ]
}

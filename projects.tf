# When you create a new project,
# 1. configure a new slack hook and add it to the SSM parameter for the endpoint.
# 2. Create a new google tag
#

# Vercel requires TXT on the apex domain for verification for each project.
resource "aws_route53_record" "this_txt_vercel_verification" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_vercel.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    "vc-domain-verify=island-drift-detailing.maxim.run,62f61f2c6b39fe5863e1", # island drift detailng
    "vc-domain-verify=island-mist-detailing.maxim.run,0f8cbee639d604a32a75",  # island mist detailng
    "vc-domain-verify=driftwood-events.maxim.run,04fe2873c57504cb78fd"        # driftwood events
  ]                                                                           # Vercel does not expose this in provider yet. // this value  came from Island Drift detailng vercel project verification UI.
}


module "cleaning_landing_page" {
  source = "./modules/project"
  name   = "cleaning-landing-page"
  ## Using vercel instead of github pages
  #   pages = {
  #     build_type = "workflow"
  #     cname = "island-drift-detailing.maxim.run"
  #     do_not_create_index_html = true
  #   }
  description        = "Cleaning Landing Page"
  visibility         = "private"
  topics             = ["car", "detailing", "business", "cleaning", "landing-page", "html", "css", "javascript", ]
  has_issues         = true
  archived           = false
  archive_on_destroy = true
  #   template = {
  #     owner = "codelawcorp"
  #     repository = "template"
  #     include_all_branches = false
  #   }

  vercel = {
    cname              = "island-drift-detailing.maxim.run"
    cname_verification = "3b1e60b4a8ee8b43.vercel-dns-017.com."
    resend_api_key     = aws_ssm_parameter.resend_api_key.value
    slack_webhook_url  = aws_ssm_parameter.cleaning_landing_page_slack_webhook_url.value
  }
}


# This is temporarily shared between projects
resource "aws_ssm_parameter" "cleaning_landing_page_slack_webhook_url" {
  name  = "/repo-as-a-code/cleaning-landing-page/slack_webhook_url"
  type  = "SecureString"
  value = "placeholder-added-manually"

  lifecycle {
    ignore_changes = [value]
  }
}


module "boat_detailing_landing_page" {
  source = "./modules/project"
  name   = "boat-detailing-landing-page"
  ## Using vercel instead of github pages
  #   pages = {
  #     build_type = "workflow"
  #     cname = "island-mist-detailing.maxim.run"
  #     do_not_create_index_html = true
  #   }
  description        = "Boat Detailing Landing Page"
  visibility         = "private"
  topics             = ["yacht", "boat", "detailing", "business", "cleaning", "landing-page", "html", "css", "javascript", ]
  has_issues         = true
  archived           = false
  archive_on_destroy = false
  template = {
    owner                = "codelawcorp"
    repository           = "template"
    include_all_branches = false
  }

  vercel = {
    cname              = "island-mist-detailing.maxim.run"
    cname_verification = "3b1e60b4a8ee8b43.vercel-dns-017.com." // udpate manually when new project is created
    resend_api_key     = aws_ssm_parameter.resend_api_key.value
    slack_webhook_url  = aws_ssm_parameter.cleaning_landing_page_slack_webhook_url.value
  }
}


module "photography_landing_page" {
  source = "./modules/project"
  name   = "photography-landing-page"
  ## Using vercel instead of github pages
  #   pages = {
  #     build_type = "workflow"
  #     cname = "island-mist-detailing.maxim.run"
  #     do_not_create_index_html = true
  #   }
  description        = "Event Photography Landing Page"
  visibility         = "private"
  topics             = ["photography", "landing-page", "html", "css", "javascript", ]
  has_issues         = true
  archived           = false
  archive_on_destroy = false
  template = {
    owner                = "codelawcorp"
    repository           = "template"
    include_all_branches = false
  }

  vercel = {
    cname              = "driftwood-events.maxim.run"           // events or ... photography? Focus on construction, wedding, beach, forest etc... ?
    cname_verification = "3b1e60b4a8ee8b43.vercel-dns-017.com." // udpate manually when new project is created
    resend_api_key     = aws_ssm_parameter.resend_api_key.value
    slack_webhook_url  = aws_ssm_parameter.cleaning_landing_page_slack_webhook_url.value
  }
}
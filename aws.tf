### SSM Parameters ### START
resource "aws_ssm_parameter" "datadog_api_key" {
  name  = "/repo-as-a-code/DD_API_KEY"
  type  = "SecureString"
  value = "placeholder-added-manually"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "datadog_app_key" {
  name  = "/repo-as-a-code/DD_APP_KEY"
  type  = "SecureString"
  value = "placeholder-added-manually"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "vercel_api_token" {
  name  = "/repo-as-a-code/VERCEL_API_TOKEN"
  type  = "SecureString"
  value = "placeholder-added-manually"
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "resend_api_key" {
  name  = "/repo-as-a-code/resend_api_key"
  type  = "SecureString"
  value = "placeholder-added-manually"
  lifecycle {
    ignore_changes = [value]
  }
}


### SSM Parameters ### END

data "aws_route53_zone" "this" {
  name = "maxim.run."
}


resource "aws_route53_record" "this_cname" {
  for_each = {
    for repo in local.repos : repo.name => repo if try(repo.pages, null) != null && try(repo.pages.cname, null) != data.aws_route53_zone.this.name
  }
  zone_id = data.aws_route53_zone.this.zone_id
  name    = try(each.value.pages.cname, null) != null ? each.value.pages.cname : "${each.key}.${data.aws_route53_zone.this.name}"
  type    = "CNAME"
  ttl     = "300"
  records = [
    "magzim21.github.io"
  ]
}

resource "aws_route53_record" "this_a" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "A"
  ttl     = "300"
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}

resource "aws_route53_record" "this_aaaa" {
  name    = data.aws_route53_zone.this.name
  zone_id = data.aws_route53_zone.this.zone_id
  type    = "AAAA"
  ttl     = "300"
  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153"
  ]
}


# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages#verifying-a-domain-for-your-user-site
resource "aws_route53_record" "txt_verification" {

  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_github-pages-challenge-magzim21.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    "69e2555f9da01b3b9b11d2005fb9a2"
  ]
}



### Resend ### START

resource "aws_route53_record" "booking_resend_dkim" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "resend._domainkey.booking.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBlotpATsv7QRLNPoyzQK9EDZH6y2RAsXX+W0pdtLe72IrWoWWGvtr2Inodu2BvabpfmwpMhKWkxz79y8jzHv8Z13yk5IWArTScg2o8ILvfe05JkwkzCQxwpul9DVH2wIdCypWBZjn0P5jo2cN07AN283cxzp+pUYWJnGRmwlRuwIDAQAB"
  ]
}

resource "aws_route53_record" "booking_resend_send_mx" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "send.booking.${data.aws_route53_zone.this.name}"
  type    = "MX"
  ttl     = "300"
  records = [
    "10 feedback-smtp.us-east-1.amazonses.com"
  ]
}

resource "aws_route53_record" "booking_resend_send_spf" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "send.booking.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    "v=spf1 include:amazonses.com ~all"
  ]
}

resource "aws_route53_record" "booking_resend_dmarc" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_dmarc.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    "v=DMARC1; p=none;"
  ]
}

resource "aws_route53_record" "booking_resend_inbound_mx" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "booking.${data.aws_route53_zone.this.name}"
  type    = "MX"
  ttl     = "300"
  records = [
    "10 inbound-smtp.us-east-1.amazonaws.com"
  ]
}

### Resend ### END


### Vercel ### START

# resource "aws_route53_record" "vercel_domain_verification" {
#   zone_id = data.aws_route53_zone.this.zone_id
#   name    = "_vercel.${data.aws_route53_zone.this.name}"
#   type    = "TXT"
#   ttl     = "300"
#   records = ["vc-domain-verify=island-drift-detailing.maxim.run,cf47fe220e9730b1efd5"] # Vercel does not expose this in provider yet. // this value  came from Island Drift detailng vercel project verification UI.
#            # "vc-domain-verify=island-mist-detailing.maxim.run,7f4b75575c7f657a6a05"
# }

### Vercel ### END

### Google Workspace ### START

# DKIM key of maxim.run, generated in admin.google.com → Apps → Google Workspace → Gmail → Authenticate email.
# Route 53 limits one TXT string to 255 characters, so the value is split into quoted chunks.
resource "aws_route53_record" "google_dkim" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "google._domainkey.${data.aws_route53_zone.this.name}"
  type    = "TXT"
  ttl     = "300"
  records = [
    join("\"\"", regexall(".{1,255}", "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5SIue+x4ImBPwj48ItlJCpdkE/9lMkOKVLgR3/Cy7vemvQ8MsDU2BJVXb4FKZuwBGl2PmrMrzg/31PC11Cro1+PLvg+lpKHeuXc5heV2Ohm9eizQ9zQinN9sJvNwKg+X8aWOAwboyijzqvyIrr897i1NF5pxX9RD4pS1insrYCAsiddluz4K4820dHC59KXmoofpiGKfMPECNSLBmek58/LeC+nHk4Y5FGjGFM6JNGgcW6akbYBgr6b5SsjTnfdOllTCbSNPyif5+yI29TPPMNML7MR8NDJb/w103Vl72Lgt6dcIAnYFGOYczSPG/bVxNpdxs5A+/3paWejAG+QAwIDAQAB"))
  ]
}

### Google Workspace ### END

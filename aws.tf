
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
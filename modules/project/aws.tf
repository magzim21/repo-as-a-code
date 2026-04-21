resource "aws_route53_record" "this_cname" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = vercel_project_domain.this.domain
  type    = "CNAME"
  ttl     = "300"
  records = ["3b1e60b4a8ee8b43.vercel-dns-017.com."]
}


resource "aws_route53_record" "this_txt" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_vercel.${var.zone_name}"
  type    = "TXT"
  ttl     = "300"
  records = [var.vercel.txt_verification]
}
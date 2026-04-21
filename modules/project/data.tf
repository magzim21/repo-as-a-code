locals {
  domain_name = try(var.vercel.cname, "${var.name}.${var.zone_name}")
}

data "aws_route53_zone" "this" {
  name = var.zone_name
}
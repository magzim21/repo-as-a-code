# personal-wealth-tracker.maxim.run and ims-lp.maxim.run move from GitHub Pages to Vercel (team codelaw), so both
# repositories can be private: Pages on a private repository needs a paid GitHub plan (Max, 2026-10-22: «Move the
# personal-wealth-tracker and ims-lp sites from GitHub Pages to Vercel (team codelaw, via Terraform), then make both
# repos private»). Vercel builds each from its prod branch with the repo's own vercel.json, like maxim-run.tf.
# Tasks: https://app.notion.com/p/402b399fe9c281c5b5b8c9a96660c129 and https://app.notion.com/p/402b399fe9c281949db2f14d9c1739dc
#
# The apex maxim.run is not owned by the codelaw team, so each domain needs its TXT proof in
# aws_route53_record.this_txt_vercel_verification (projects.tf); the provider does not expose the value: read it with
# GET https://api.vercel.com/v9/projects/<project>/domains/<domain>?slug=codelaw (field verification[].value).

locals {
  pages_to_vercel = toset(["personal-wealth-tracker", "ims-lp"])
}

resource "vercel_project" "pages_to_vercel" {
  for_each = local.pages_to_vercel
  name     = each.key

  git_repository = {
    type              = "github"
    repo              = "magzim21/${module.repos[each.key].repository.name}"
    production_branch = "prod"
  }
}

resource "vercel_project_domain" "pages_to_vercel" {
  for_each   = local.pages_to_vercel
  project_id = vercel_project.pages_to_vercel[each.key].id
  domain     = "${each.key}.maxim.run"
}

# The CNAME records were made for GitHub Pages by aws_route53_record.this_cname (aws.tf, for repos with pages); they
# move here and point at Vercel instead of magzim21.github.io.
resource "aws_route53_record" "pages_to_vercel" {
  for_each = local.pages_to_vercel
  zone_id  = data.aws_route53_zone.this.zone_id
  name     = "${each.key}.${data.aws_route53_zone.this.name}"
  type     = "CNAME"
  ttl      = "300"
  records  = ["cname.vercel-dns.com"]
}

moved {
  from = aws_route53_record.this_cname["personal-wealth-tracker"]
  to   = aws_route53_record.pages_to_vercel["personal-wealth-tracker"]
}

moved {
  from = aws_route53_record.this_cname["ims-lp"]
  to   = aws_route53_record.pages_to_vercel["ims-lp"]
}

module "cleaning_landing_page" {
  source = "./modules/project"
  name   = "cleaning-landing-page"
  ## Using vercel instead of github pages
  #   pages = {
  #     build_type = "workflow"
  #     cname = "island-drift-detailing.maxim.run"
  #     do_not_create_index_html = true
  #   }
  description = "Cleaning Landing Page"
  visibility  = "public"
  topics      = ["cleaning", "landing-page", "html", "css", "javascript", ]
  archived    = false
  #   template = {
  #     owner = "codelawcorp"
  #     repository = "template"
  #     include_all_branches = false
  #   }

  vercel = {
    cname            = "island-drift-detailing.maxim.run"
    txt_verification = "vc-domain-verify=island-drift-detailing.maxim.run,d0407c02048b2444f102" # Vercel does not expose this in provider yet. 
  }
}


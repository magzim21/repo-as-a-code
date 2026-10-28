# Datadog RUM of https://ims-lp.maxim.run (Vercel project vercel_project.pages_to_vercel["ims-lp"], pages-to-vercel.tf):
# page loads, errors and resource timings, sent only after the visitor's analytics consent (magzim21/ims-lp rum.js,
# consent.js) and named on its privacy page https://ims-lp.maxim.run/privacy. Task:
# https://app.notion.com/p/407b399fe9c28121a7a9fb128e766ded ("every site of Max has Datadog RUM", Max, 2026-10-27).
# Its own file, beside the RUM of personal-wealth-tracker in pages-to-vercel.tf and of maxim.run in maxim-run.tf.
resource "datadog_rum_application" "ims_lp" {
  name                              = "ims-lp.maxim.run"
  type                              = "browser"
  rum_event_processing_state        = "ALL"
  product_analytics_retention_state = "NONE" # RUM data only, 30 days: the site's privacy page says so
}

# Read by magzim21/ims-lp scripts/build.mjs at Vercel build time and written into its rum.js; without both the site
# loads no RUM. Not sensitive: every visitor's browser gets them. Production only, so preview builds send nothing.
resource "vercel_project_environment_variables" "ims_lp" {
  project_id = vercel_project.pages_to_vercel["ims-lp"].id
  variables = [
    {
      key       = "DD_RUM_APPLICATION_ID"
      value     = datadog_rum_application.ims_lp.id
      target    = ["production"]
      sensitive = false
    },
    {
      key       = "DD_RUM_CLIENT_TOKEN"
      value     = datadog_rum_application.ims_lp.client_token
      target    = ["production"]
      sensitive = false
    },
  ]
}

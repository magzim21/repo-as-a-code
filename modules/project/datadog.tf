resource "datadog_synthetics_test" "this" {
  name      = local.domain_name
  type      = "api"
  subtype   = "http"
  status    = "live"
  message   = "Notify @slack-codelawcorp-alerts"
  locations = ["aws:ca-central-1"]
  tags      = ["env:prod"]

  request_definition {
    method = "GET"
    url    = "https://${local.domain_name}"
  }

  request_headers = {
    Content-Type = "application/json"
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  options_list {
    tick_every = 1800
    retry {
      count    = 2
      interval = 300
    }
    monitor_options {
      renotify_interval = 120
    }
  }
}



resource "datadog_rum_application" "this" {
  name                              = local.domain_name
  type                              = "browser"
  rum_event_processing_state        = "ALL"
  product_analytics_retention_state = "MAX"
}
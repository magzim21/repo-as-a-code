resource "datadog_synthetics_test" "test_uptime" {
  name      = "island-drift-detailing.${data.aws_route53_zone.this.name}"
  type      = "api"
  subtype   = "http"
  status    = "live"
  message   = "Notify @pagerduty" # TODO / create slack channel
  locations = ["aws:ca-central-1"]
  tags      = ["env:prod"]

  request_definition {
    method = "GET"
    url    = "https://island-drift-detailing.${data.aws_route53_zone.this.name}"
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

resource "github_actions_secret" "datadog_api_key" {
  repository      = "repo-as-a-code"
  secret_name     = "DD_API_KEY"
  plaintext_value = "placeholder-added-manually"
  lifecycle {
    ignore_changes = [remote_updated_at]
  }
}

resource "github_actions_secret" "datadog_app_key" {
  repository      = "repo-as-a-code"
  secret_name     = "DD_APP_KEY"
  plaintext_value = "placeholder-added-manually"
  lifecycle {
    ignore_changes = [remote_updated_at]
  }
}
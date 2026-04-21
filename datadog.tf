

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
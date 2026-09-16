output "domain_name" {
  value = local.domain_name
}

output "rum_application_api_key_id" {
  value = datadog_rum_application.this.api_key_id
}
output "rum_application_client_token" {
  value = datadog_rum_application.this.client_token
}
output "rum_application_id" {
  value = datadog_rum_application.this.id
}

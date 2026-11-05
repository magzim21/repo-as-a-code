# Datadog Logs of Day Room (magzim21/day-room): its nightly job bin/auto-sessions-run.mjs on Max's Mac sends every
# run of the 00:30 Actual Sessions fill to Datadog Logs, service day-room (Max, 2026-11-03: «do both»; 2026-11-05: «you
# should create this key with Terraform»). Its own API key, so it can be revoked without touching any other sender.
resource "datadog_api_key" "day_room" {
  name = "day-room auto-sessions (Max's Mac)"
}

# The job reads it at each run with the Mac's AWS credentials (aws ssm get-parameter --with-decryption); it is never
# written into the repo, the Keychain or a file.
resource "aws_ssm_parameter" "day_room_dd_api_key" {
  name  = "/day-room/DD_API_KEY"
  type  = "SecureString"
  value = datadog_api_key.day_room.key
}

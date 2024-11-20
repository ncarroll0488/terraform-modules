output "webhook_url" {
  value       = aws_codepipeline_webhook.main.url
  description = "Webhook URL for further github configuration"
  sensitive   = true
}

output "webhook_token" {
  value       = random_password.password.result
  description = "auth token for the github webhook"
  sensitive   = true
}

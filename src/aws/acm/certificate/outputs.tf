output "certificate_arn" {
  value       = aws_acm_certificate.main.arn
  description = "ARN of the certificate"
}

output "domain_validation_options" {
  value = aws_acm_certificate.main.domain_validation_options
}

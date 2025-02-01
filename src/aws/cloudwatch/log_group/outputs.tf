output "log_group_arn" {
  value       = aws_cloudwatch_log_group.main.arn
  description = "ARN of the log group"
}

output "log_group_name" {
  value       = aws_cloudwatch_log_group.main.name
  description = "Name of the log group"
}

output "log_group_kms_key_id" {
  value       = aws_cloudwatch_log_group.main.kms_key_id
  description = "ARN of the KMS key used to encrypt logs"
}

output "ssm_parameter_arn" {
  description = "ARN of the SSM parameter"
  value       = aws_ssm_parameter.main.arn
}

output "ssm_parameter_name" {
  description = "Name of the SSM parameter"
  value       = aws_ssm_parameter.main.name
}

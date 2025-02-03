output "ssm_parameter_arn" {
  description = "ARN of the SSM parameter"
  value       = aws_ssm_parameter.main.arn
}

output "ssm_parameter_name" {
  description = "Name of the SSM parameter"
  value       = aws_ssm_parameter.main.name
}

output "set_value_command" {
  description = "Run this command to set the value of the secret"
  value       = "aws ssm put-parameter --name '${aws_ssm_parameter.main.name}' --overwrite --value 'YOUR_VALUE_HERE'"
}

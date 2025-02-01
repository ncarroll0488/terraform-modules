output "execution_role_arn" {
  value       = aws_iam_role.execution.arn
  description = "ARN of the execution role"
}

output "task_role_arn" {
  value       = aws_iam_role.task.arn
  description = "ARN of the task role"
}

output "service_role_arn" {
  value       = aws_iam_role.service.arn
  description = "ARN of the service role"
}

output "execution_role_arn" {
  value       = aws_iam_role.execution.arn
  description = "ARN of the execution role"
}

output "task_role_arns" {
  value       = { for x, y in aws_iam_role.task : x => y.arn }
  description = "ARN of the task role"
}

output "service_role_arn" {
  value       = aws_iam_role.service.arn
  description = "ARN of the service role"
}

output "eventbridge_role_arn" {
  value       = var.enable_eventbridge_role ? aws_iam_role.events[0].arn : ""
  description = "ARN of the role used by eventbridge (Cloudwatch events)"
}

output "service_name" {
  description = "The name of the ECS service."
  value       = aws_ecs_service.main.name
}

output "service_arn" {
  description = "The ARN of the ECS service."
  value       = aws_ecs_service.main.id
}

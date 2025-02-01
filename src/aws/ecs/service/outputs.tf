output "service_name" {
  description = "The name of the ECS service."
  value       = aws_ecs_service.main.name
}

output "service_arn" {
  description = "The ARN of the ECS service."
  value       = aws_ecs_service.main.id
}

output "service_dns" {
  description = "DNS names corresponding to load balanced services"
  value       = { for service_id, lb in data.aws_lb.main : service_id => lb.dns_name }
}

output "service_name" {
  description = "The name of the ECS service."
  value       = aws_ecs_service.main.name
}

output "service_arn" {
  description = "The ARN of the ECS service."
  value       = aws_ecs_service.main.id
}

output "service_dns" {
  description = "DNS names and zone corresponding to load balanced services"
  value       = { for service_id, lb in data.aws_lb.main : service_id => { dns = lb.dns_name, zone = lb.zone_id } }
}

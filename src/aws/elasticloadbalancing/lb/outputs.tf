output "lb_arn" {
  value       = aws_lb.main.arn
  description = "ARN of the load balancer"
}

output "lb_arn_suffix" {
  value       = aws_lb.main.arn_suffix
  description = "LB ARN suffix"
}

output "lb_zone_id" {
  value       = aws_lb.main.zone_id
  description = "Zone ID of the load balancer's Route53 records (for aliases)"
}

output "lb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The DNS hostname of the LB - for CNAMEs, etc."
}

output "target_group_arns" {
  value = { for x, y in aws_lb_target_group.main : x => y.arn }
}

output "ns_records" {
  description = "Nameserver records"
  value       = aws_route53_zone.main.name_servers
}

output "zone_id" {
  description = "ID of the created zone"
  value       = aws_route53_zone.main.zone_id
}

output "zone_arn" {
  description = "ARN of the created zone"
  value       = aws_route53_zone.main.arn
}

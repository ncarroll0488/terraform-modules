output "ns_records" {
  description = "Nameserver records"
  value = aws_route53_zone.main.name_servers
}

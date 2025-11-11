output "instance_ids" {
  description = "IDs of the NAT gateway instances, by name"
  value       = { for x, y in aws_instance.main : x => y.id }
}

output "instance_arns" {
  description = "ARNs of the NAT gateway instances, by name"
  value       = { for x, y in aws_instance.main : x => y.arn }
}

output "instance_profile" {
  description = "Name of the instance profile, if a role was provided"
  value       = one(aws_iam_instance_profile.main[*].name)
}

output "public_ips" {
  description = "NAT Gateway public IPs by name"
  value       = { for x, y in aws_eip.main : x => y.public_ip }
}

output "private_ips" {
  description = "Private IPs of the NAT gateway instances, by name"
  value       = { for x, y in aws_instance.main : x => y.private_ip }
}

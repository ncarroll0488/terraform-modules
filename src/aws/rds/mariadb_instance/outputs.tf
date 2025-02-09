output "master_user_secret" {
  description = "Information about the master secret"
  value       = aws_db_instance.main.master_user_secret
}

output "address" {
  description = "DNS name of the cluster"
  value       = aws_db_instance.main.address
}

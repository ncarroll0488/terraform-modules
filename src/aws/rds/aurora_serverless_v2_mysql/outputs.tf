output "master_user_secret" {
  description = "Information about the master secret"
  value       = aws_rds_cluster.main.master_user_secret
}

output "cluster_arn" {
  description = "ARN of the cluster"
  value       = aws_rds_cluster.main.arn
}

output "cluster_identifier" {
  description = "ID of the cluster"
  value       = aws_rds_cluster.main.cluster_identifier
}

output "endpoint" {
  description = "DNS name of the cluster"
  value       = aws_rds_cluster.main.endpoint
}

output "master_username" {
  description = "Master username"
  value       = aws_rds_cluster.main.master_username
  sensitive   = true
}

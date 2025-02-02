output "cluster_arn" {
  description = "ARN of the cluster"
  value       = aws_elasticache_cluster.main.arn
}

output "cache_nodes" {
  description = "List of node objects including id, address, port and availability_zone"
  value       = aws_elasticache_cluster.main.cache_nodes
}

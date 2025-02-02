resource "aws_elasticache_cluster" "main" {
  cluster_id                 = var.cluster_name
  engine                     = "redis"
  node_type                  = var.node_type
  num_cache_nodes            = var.num_cache_nodes
  parameter_group_name       = var.parameter_group_name
  engine_version             = var.engine_version
  port                       = 6379
  security_group_ids         = toset(var.security_group_ids)
  subnet_group_name          = aws_elasticache_subnet_group.main.name
  tags                       = merge(var.tags, { Name = var.cluster_name })
  transit_encryption_enabled = var.transit_encryption_enabled
}

resource "aws_elasticache_subnet_group" "main" {
  name        = var.cluster_name
  subnet_ids  = toset(var.subnet_ids)
  description = "Subnet group for ${var.cluster_name}"
}

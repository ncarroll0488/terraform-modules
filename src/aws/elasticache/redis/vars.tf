variable "cluster_name" {
  type        = string
  description = "Identifier for the redis cluster"
}

variable "node_type" {
  type        = string
  description = "The node type to use for redis. See https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/CacheNodes.SupportedTypes.html"
}

variable "num_cache_nodes" {
  type        = number
  description = "The number of cache nodes to use in the cluster"
  default     = 1
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the redis parameter group"
}

variable "engine_version" {
  type        = string
  description = "Engine version"
}

variable "redis_port" {
  type        = number
  description = "The port redis will listen on"
  default     = 6379
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs to use"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to put into the cluster's subnet group"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags"
  default     = {}
}

variable "transit_encryption_enabled" {
  type        = bool
  description = "Enable encrypted connections"
  default     = false
}

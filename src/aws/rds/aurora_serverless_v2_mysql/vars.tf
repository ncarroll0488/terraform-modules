variable "cluster_name" {
  type        = string
  description = "Name of the DB cluster"
}

variable "engine_version" {
  type        = string
  description = "Version of the engine to use."
}

variable "db_name" {
  type        = string
  description = "Default DB name"
  default     = "main"
}

variable "master_username" {
  type        = string
  description = "Master username"
  default     = "main"
  sensitive   = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS key to use for encryption"
  default     = null
}

variable "master_password_kms_key" {
  type        = string
  description = "KMS key to use for the master password"
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "DB instances will live in these subnets"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups to give to the DB cluster"
}

variable "max_db_capacity" {
  type        = number
  description = "Maximum DB capacity units for serverless nodes"
  default     = 1
}

variable "min_db_capacity" {
  type        = number
  description = "Minimum DB capacity units for serverless nodes"
  default     = 0
}

variable "db_pause_timer" {
  type        = number
  description = "The DB will pause after this many seconds of inactivity"
  default     = 3600
}

variable "instance_count" {
  type        = number
  description = "The number of serverless instances in the cluster"
  default     = 1
}

variable "tags" {
  type        = map(string)
  description = "Tags to add to the cluster's resources"
  default     = {}
}

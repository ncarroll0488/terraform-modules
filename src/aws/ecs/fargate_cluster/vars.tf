variable "cluster_name" {
  type        = string
  description = "Name of the cluster, used in tagging and IAM elements"
}

variable "container_insights" {
  type        = bool
  description = "Enabled container insights"
  default     = true
}

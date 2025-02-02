variable "vpc_security_group_map" {
  type        = map(any)
  description = "A map of SG rules"
  default     = {}
}

variable "vpc_security_group_json" {
  type        = string
  description = "A json blob of SG rules. Used to overcome data type issues interragrunt"
  default     = "{}"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to attach security groups to"
}

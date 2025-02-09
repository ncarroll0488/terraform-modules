variable "domain_name" {
  type        = string
  description = "Domain name for the cert"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "A list of extra DNS names"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Extra tags"
  default     = {}
}

variable "domain_validation_zones" {
  type        = map(string)
  description = "A map of domain name => zone ID for auto-populating route53 validation records"
  default     = {}
}

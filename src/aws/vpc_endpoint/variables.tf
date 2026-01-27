variable "vpc_id" {
  description = "ID of the VPC in which to create the interface"
  type        = string
}

variable "service_domains" {
  description = "A list of domain components used to assemble the service endpoint name. You almost certainly do not need to change this in production, but the option exists for edge cases like running against a test API."
  type        = list(string)
  default     = ["com", "amazonaws"]
}

variable "gateway_services" {
  description = "A list of AWS services to provision as gateway endpoints"
  default     = []
  type        = list(string)
}

variable "gateway_route_tables" {
  description = "A list of route tables to which gateway service endponts will be attached"
  type        = list(string)
  default     = []
}

variable "gateway_policies" {
  description = "A map of {service => JSON} documents used as resource access policies on gateway-type subnets"
  type        = map(string)
  default     = {}
  validation {
    condition     = alltrue([for x, y in var.gateway_policies : can(jsondecode(y))])
    error_message = "One or more gateway policy documents did not parse as valid JSON."
  }
}

variable "interface_services" {
  description = "A list of AWS services to provision as interface endpoints"
  default     = []
  type        = list(string)
}

variable "interface_security_group_ids" {
  description = "Security group IDs to assign to interface-based service endpoints"
  type        = list(string)
  default     = []
}

variable "interface_subnets" {
  description = "A list of subnet IDs into which interface service endpoint interfaces will be placed"
  type        = list(string)
  default     = []
}

variable "lb_name" {
  type        = string
  description = "Name of the LB"
}

variable "lb_type" {
  type        = string
  description = "Type of the LB"
  default     = null
  validation {
    condition     = var.lb_type == null || contains(["application", "gateway", "network"], lower(var.lb_type))
    error_message = "LB type must be one of application, gateway, network"
  }
}

variable "internal" {
  type        = bool
  description = "Make this an internal LB"
  default     = null
}

variable "ip_address_type" {
  type        = string
  description = "Type of IP addresses to use"
  default     = null
  validation {
    condition     = var.ip_address_type == null || contains(["ipv4", "dualstack", "dualstack-without-public-ipv4"], lower(var.ip_address_type))
    error_message = "IP address type invalid. Must be one of ipv4, dualstack, dualstack-without-public-ipv4."
  }
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets into which the load balancer is placed"
}

variable "enable_zonal_shift" {
  type        = bool
  description = "Enable zonal shift"
  default     = null
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#enable_deletion_protection-4"
  default     = true
}

variable "customer_owned_ipv4_pool" {
  type        = string
  description = "Customer IP pool for this LB"
  default     = null
}

variable "client_keep_alive" {
  type        = number
  description = "Client keep alive value in seconds. The valid range is 60-604800 seconds. The default is 3600 seconds."
  default     = null
  validation {
    condition     = var.client_keep_alive == null || (var.client_keep_alive >= 60 && var.client_keep_alive <= 604800)
    error_message = "Client keep alive must be between 60 and 608400, inclusive"
  }
}

variable "security_groups" {
  type        = list(string)
  description = "Security groups IDs to use on this load balancer"
  default     = null
}

variable "enable_cross_zone_load_balancing" {
  type        = bool
  description = "Enable coss-zone load balancing. Always on for application LBs"
  default     = null
}

variable "dns_record_client_routing_policy" {
  type        = string
  description = "How traffic is distributed among the load balancer Availability Zones"
  default     = null
  validation {
    condition     = var.dns_record_client_routing_policy == null || contains(["any_availability_zone", "availability_zone_affinity", "partial_availability_zone_affinity"], lower(var.dns_record_client_routing_policy))
    error_message = "DNS routing policy invalid. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#dns_record_client_routing_policy-4"
  }
}

variable "preserve_host_header" {
  type        = bool
  description = "Preserve the HTTP Host header"
  default     = null
}

variable "xff_header_processing_mode" {
  type        = string
  description = "Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request"
  default     = null
  validation {
    condition     = var.xff_header_processing_mode == null || contains(["append", "preserve", "remove"], lower(var.xff_header_processing_mode))
    error_message = "XFF header processing must be one of append, preserve, remove"
  }
}

variable "enable_http2" {
  type        = bool
  description = "Enable HTTP/2"
  default     = null
}

variable "drop_invalid_header_fields" {
  type        = bool
  description = "Remove invalid headers from the request"
  default     = null
}

variable "desync_mitigation_mode" {
  type        = string
  description = "How the load balancer handles requests that might pose a security risk to an application due to HTTP desync."
  default     = null
  validation {
    condition     = var.desync_mitigation_mode == null || contains(["monitor", "defensive", "strictest"], lower(var.desync_mitigation_mode))
    error_message = "Desync mitigation must be one of monitor, defensive, strictest"
  }
}

variable "connection_logs_bucket" {
  type        = string
  description = "Bucket used to store connection logs"
  default     = ""
}

variable "connection_logs_prefix" {
  type        = string
  description = "Path prefix for connection log storage"
  default     = null
}

variable "enable_connection_logs" {
  type        = string
  description = "Toggle connection logs"
  default     = null
}


variable "access_logs_bucket" {
  type        = string
  description = "Bucket used to store access logs"
  default     = ""
}

variable "access_logs_prefix" {
  type        = string
  description = "Path prefix for access log storage"
  default     = null
}

variable "enable_access_logs" {
  type        = string
  description = "Toggle access logs"
  default     = null
}

variable "eip_mappings" {
  type        = map(string)
  description = "A map of subnet_id => eipalloc"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of tags"
  default     = {}
}

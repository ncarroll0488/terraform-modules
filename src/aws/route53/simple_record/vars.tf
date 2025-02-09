variable "zone_id" {
  type        = string
  description = "ID of the zone into which records are placed"
}

variable "record_name" {
  type        = string
  description = "Name of record, like foo.bar.com"
}

variable "record_type" {
  type        = string
  description = "Type of the record, like A, NS, TXT, etc"
  default     = "A"
}

variable "ttl" {
  type        = number
  description = "TTL of the record"
  default     = 300
}

variable "record_values" {
  type        = list(string)
  description = "A list of values for the record, such as an IP address for an A record"
  default     = []
}

variable "alias_name" {
  type        = string
  description = "Alias target. This changes the record to an alias when set"
  default     = ""
}

variable "alias_zone_id" {
  type        = string
  description = "The hosted zone ID of your alias record. Leave blank to use var.zone_id"
  default     = ""
}

variable "alias_eval_target_health" {
  type        = bool
  description = "Enable to evaluate alias target health"
  default     = false
}

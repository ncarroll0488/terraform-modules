variable "json_documents" {
  type        = list(string)
  description = "JSON documents to load and parse"
}

variable "allow_duplicate_cidrs" {
  type        = bool
  default     = false
  description = "Allow duplicate CIDRs"
}

variable "allow_overlapping_cidrs" {
  type        = bool
  default     = false
  description = "Allow CIDRs with overlapping ranges"
}

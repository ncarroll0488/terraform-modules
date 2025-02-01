variable "log_group_name" {
  type        = string
  description = "Name prefix of the log group."
}

variable "log_group_skip_destroy" {
  type        = bool
  default     = true
  description = "Skip destroying of the log group when deleting resources"
}

variable "log_group_class" {
  type        = string
  default     = "STANDARD"
  description = "Type of log group storage. Must be one of `STANDARD`, `INFREQUENT_ACCESS`"
  validation {
    condition     = contains(["STANDARD", "INFREQUENT_ACCESS"], upper(var.log_group_class))
    error_message = "Log group class must one of STANDARD, INFREQUENT_ACCESS"
  }
}

variable "log_group_retention_in_days" {
  type        = number
  default     = 90
  description = "Number of days to retain logs"
  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_group_retention_in_days)
    error_message = "Invalid log group retention. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group ."
  }
}

variable "log_group_kms_key_id" {
  type        = string
  default     = null
  description = "KMS Key to use to encrypt logs"
}

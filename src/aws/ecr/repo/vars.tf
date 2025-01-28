variable "ecr_repo_name" {
  type        = string
  description = "Name of the repo"
}

variable "image_tag_mutability" {
  type        = bool
  description = "Set to False for immutable tags"
  default     = false
}

variable "image_scanning_enabled" {
  type        = bool
  description = "Enables automated scanning of images on push"
  default     = true
}

variable "encryption_type" {
  type        = string
  description = "The type of encryption to use (kms or aes256)"
  default     = ""
  validation {
    condition     = contains(["kms", "aes256", ""], lower(var.encryption_type))
    error_message = "Accepted values for encryption_type: ['kms', 'aes256', '']."
  }
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of a KMS key used to encrypt this repo"
  default     = ""
}

variable "kms_key_rotation_days" {
  type        = number
  description = "Interval of KMS key rotation, in days"
  default     = null
}

variable "use_aws_managed_kms" {
  type        = bool
  description = "Enable this to use aws-managed KMS keys for encryption, rather than creating one"
  default     = true
}

variable "parameter_name" {
  type        = string
  description = "Name of the parameter"
}

variable "password_min_length" {
  type        = number
  description = "Length of the password"
  default     = 32
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key used to encrypt this secret"
  default     = null
}

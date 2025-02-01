variable "kms_key_description" {
  description = "Description of this KMS key"
  type        = string
}

variable "key_rotation_days" {
  type        = number
  description = "How frequently the key is rotated, in days"
  default     = -1
  validation {
    condition     = var.key_rotation_days == -1 || (var.key_rotation_days >= 90 && var.key_rotation_days <= 2560)
    error_message = "Key rotation must be -1 (disabled) or between 90 and 2560, inclusive"
  }
}

variable "key_deletion_window" {
  type        = number
  description = "Deletion window of the key, in days"
  default     = null
}

variable "key_usage" {
  type        = string
  description = "Intended use of the key"
  default     = "ENCRYPT_DECRYPT"
  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "SIGN_VERIFY", "GENERATE_VERIFY_MAC"], upper(var.key_usage))
    error_message = "Invalid key usage. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#key_usage-2 ."
  }
}

variable "custom_key_store_id" {
  type        = string
  description = "ID of the KMS Custom Key Store where the key will be stored"
  default     = null
}

variable "customer_master_key_spec" {
  type    = string
  default = "SYMMETRIC_DEFAULT"
  validation {
    condition = contains(
      [
        "SYMMETRIC_DEFAULT",
        "RSA_2048",
        "RSA_3072",
        "RSA_4096",
        "HMAC_256",
        "ECC_NIST_P256",
        "ECC_NIST_P384",
        "ECC_NIST_P521",
        "ECC_SECG_P256K1"
    ], upper(var.customer_master_key_spec))
    error_message = "Invalid spec. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#customer_master_key_spec-2 ."
  }
}

variable "enable_key" {
  type        = bool
  description = "Enable this key"
  default     = true
}

variable "multi_region" {
  type        = bool
  description = "Make this a multi_region key"
  default     = true
}

variable "xks_key_id" {
  type        = string
  description = "Identifies the external key that serves as key material for the KMS key"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for this key"
  default     = {}
}

variable "key_names" {
  type        = list(string)
  description = "A list of key aliases to create"
  default = []
}

locals {
  use_aws_managed_kms = lower(var.encryption_type) == "kms" && var.use_aws_managed_kms && var.kms_key_arn == ""
  provision_kms       = lower(var.encryption_type) == "kms" && !var.use_aws_managed_kms && var.kms_key_arn == ""
  kms_key_arn         = local.provision_kms ? aws_kms_key.main["main"].arn : var.kms_key_arn
}

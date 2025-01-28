resource "aws_kms_key" "main" {
  for_each                = toset(local.provision_kms ? ["main"] : [])
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = var.kms_key_rotation_days != null
  rotation_period_in_days = var.kms_key_rotation_days
}

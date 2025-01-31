resource "aws_ecr_repository" "main" {
  name                 = var.ecr_repo_name
  force_delete         = true
  image_tag_mutability = var.image_tag_mutability ? "MUTABLE" : "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = var.image_scanning_enabled
  }

  # If using KMS
  dynamic "encryption_configuration" {
    for_each = lower(var.encryption_type) == "kms" ? ["a"] : []
    content {
      encryption_type = "KMS"
      kms_key         = local.use_aws_managed_kms ? null : local.kms_key_arn
    }
  }

  # If using AES256
  dynamic "encryption_configuration" {
    for_each = lower(var.encryption_type) == "aes256" ? ["a"] : []
    content {
      encryption_type = "AES256"
    }
  }

  tags = {
    Name = var.ecr_repo_name
  }
}

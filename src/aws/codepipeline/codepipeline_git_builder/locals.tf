locals {
  create_codestar_connection   = var.codestar_connection_arn == ""
  codestar_connection_arn     = local.create_codestar_connection ? aws_codestarconnections_connection.main["main"].arn : var.codestar_connection_arn
  
  create_artifacts_bucket     = var.artifacts_bucket_name == ""
  artifacts_bucket_name       = local.create_artifacts_bucket ? aws_s3_bucket.artifacts["main"].bucket : var.artifacts_bucket_name
  artifacts_bucket_kms_key_id = var.artifacts_bucket_encryption_algorithm == "aws:kms" ? var.artifacts_bucket_kms_key_id : null
}

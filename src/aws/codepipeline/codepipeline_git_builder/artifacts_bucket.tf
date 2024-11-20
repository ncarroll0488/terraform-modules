resource "aws_s3_bucket" "artifacts" {
  for_each = toset(local.create_artifacts_bucket ? ["main"] : [])

  # Name prefix nearly eliminates the chance of collisions
  bucket_prefix = "${var.pipeline_name}-artifacts"

  policy = null
}

/* TODO 
# Ensure the bucket policy is specifically managed and empty.
resource "aws_s3_bucket_policy" "artifacts" {
  for_each = toset(local.create_artifacts_bucket ? ["main"] : [])

  bucket = aws_s3_bucket.artifacts["main"].id
  policy = "{}"
}
*/

# Make sure public access is blocked
resource "aws_s3_bucket_public_access_block" "artifacts" {
  for_each = toset(local.create_artifacts_bucket ? ["main"] : [])

  bucket = aws_s3_bucket.artifacts["main"].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Make sure encryption is confgured
resource "aws_s3_bucket_server_side_encryption_configuration" "artifacts" {
  for_each = toset(local.create_artifacts_bucket ? ["main"] : [])

  bucket = aws_s3_bucket.artifacts["main"].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.artifacts_bucket_kms_key_id
      sse_algorithm     = var.artifacts_bucket_encryption_algorithm
    }
  }
}

# If bringing our own bucket, simply datasource it.
data "aws_s3_bucket" "artifacts" {
  bucket = local.artifacts_bucket_name
}



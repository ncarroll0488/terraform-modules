resource "aws_cloudwatch_log_group" "main" {
  name_prefix       = var.log_group_name
  skip_destroy      = var.log_group_skip_destroy
  log_group_class   = var.log_group_class
  retention_in_days = var.log_group_retention_in_days
  kms_key_id        = var.log_group_kms_key_id
  tags = {
    Name = var.log_group_name
  }
}

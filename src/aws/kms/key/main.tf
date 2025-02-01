resource "aws_kms_key" "main" {
  description              = var.kms_key_description
  enable_key_rotation      = var.key_rotation_days != -1
  rotation_period_in_days  = var.key_rotation_days != -1 ? var.key_rotation_days : null
  deletion_window_in_days  = var.key_deletion_window
  key_usage                = upper(var.key_usage)
  custom_key_store_id      = var.custom_key_store_id
  customer_master_key_spec = var.customer_master_key_spec
  is_enabled               = var.enable_key
  multi_region             = var.multi_region
  xks_key_id               = var.xks_key_id

  # I can think of no reason one wouldn't want this in the real world
  bypass_policy_lockout_safety_check = false

  tags   = merge(var.tags, { Name = sort(var.key_names)[0] })
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_kms_alias" "main" {
  for_each      = toset(var.key_names)
  name          = "alias/${each.value}"
  target_key_id = aws_kms_key.main.key_id
}

data "aws_caller_identity" "main" {}

data "aws_iam_policy_document" "main" {
  policy_id = "main"
  statement {
    actions = ["kms:*"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.main.account_id}:root"]
    }
    resources = ["*"]
    sid       = "EnableIAM"
  }
  dynamic "statement" {
    for_each = length(var.allowed_aws_services) > 0 ? ["a"] : []
    content {
      principals {
        type        = "Service"
        identifiers = toset([var.allowed_aws_services])
      }
      actions = [
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:Decrypt"
      ]
      resources = "*"
    }
  }
}

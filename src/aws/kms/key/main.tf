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

  tags = merge(var.tags, { Name = sort(var.key_names)[0] })
}

resource "aws_kms_alias" "main" {
  for_each      = toset(var.key_names)
  name          = "alias/${each.value}"
  target_key_id = aws_kms_key.main.key_id
}

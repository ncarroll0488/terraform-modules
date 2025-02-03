resource "aws_ssm_parameter" "main" {
  name            = var.parameter_name
  type            = "SecureString"
  value           = sensitive(random_password.main.result)
  lifecycle {
    ignore_changes = [
      value
    ]
  }
  key_id = var.kms_key_arn
}

resource "random_password" "main" {
  length = var.password_min_length
}

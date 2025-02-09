resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = local.alias ? null : var.ttl
  records = local.alias ? null : toset(var.record_values)

  dynamic "alias" {
    for_each = local.alias ? ["a"] : []
    content {
      name                   = var.alias_name
      zone_id                = local.alias_zone_id
      evaluate_target_health = var.alias_eval_target_health
    }
  }
}

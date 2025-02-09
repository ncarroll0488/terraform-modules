resource "aws_route53_record" "main" {
  for_each = { for x in aws_acm_certificate.main.domain_validation_options : x.domain_name => x if contains(keys(var.domain_validation_zones), x.domain_name) }
  zone_id  = lookup(var.domain_validation_zones, each.key)
  type     = each.value.resource_record_type
  name     = each.value.resource_record_name
  records  = [each.value.resource_record_value]
  ttl      = 300
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}

resource "aws_route53_zone" "main" {
  name = var.dns_name
  dynamic "vpc" {
    for_each = var.private_vpc_associations
    content {
      vpc_region = try(each.value.region, null)
      vpc_id     = each.value.vpc_id
    }
  }
}

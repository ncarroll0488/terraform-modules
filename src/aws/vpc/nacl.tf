resource "aws_network_acl" "main" {
  count  = length(var.nacl_rules) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name} NACL"
  }
}

resource "aws_network_acl_rule" "main" {
  for_each = var.nacl_rules

  network_acl_id  = aws_network_acl.main[0].id
  egress          = each.value.egress
  protocol        = each.value.protocol
  rule_number     = each.key
  rule_action     = each.value.rule_action
  cidr_block      = can(regex("/:/", each.value.cidr_block)) ? null : each.value.cidr_block
  ipv6_cidr_block = can(regex("/:/", each.value.cidr_block)) ? each.value.cidr_block : null
  from_port       = try(each.value.from_port, null)
  to_port         = try(each.value.to_port, null)
  icmp_type       = try(each.value.icmp_type, null)
  icmp_code       = try(each.value.icmp_code, null)
}

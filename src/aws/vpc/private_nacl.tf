resource "aws_network_acl" "private" {
  count  = length(var.private_nacl_rules) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name} NACL"
  }
}

resource "aws_network_acl_rule" "private" {
  for_each = var.private_nacl_rules

  network_acl_id  = aws_network_acl.private[0].id
  egress          = each.value.egress
  protocol        = each.value.protocol
  rule_number     = each.key
  rule_action     = each.value.rule_action
  cidr_block      = try(each.value.cidr_block, null)
  ipv6_cidr_block = try(each.value.ipv6_cidr_block, null)
  from_port       = try(each.value.from_port, null)
  to_port         = try(each.value.to_port, null)
  icmp_type       = try(each.value.icmp_type, null)
  icmp_code       = try(each.value.icmp_code, null)
}

resource "aws_network_acl_association" "private" {
  for_each       = length(var.private_nacl_rules) > 0 ? local.private_subnet_definitions : {}
  network_acl_id = aws_network_acl.private[0].id
  subnet_id      = aws_subnet.private[each.key].id
}


resource "aws_security_group" "sg" {
  for_each    = local.vpc_security_group_map
  vpc_id      = var.vpc_id
  name        = each.key
  description = each.value.description
  tags = {
    Name = each.key
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

/* SGrules for IPV4 source/dest */
resource "aws_security_group_rule" "ipv4" {
  for_each          = { for rule in local.security_group_rule_associations : format("%s-%s", rule.group_name, rule.rule_name) => rule if rule.ipv4_cidr_blocks != [] && rule.rule_name != "" }
  type              = each.value.type
  cidr_blocks       = each.value.ipv4_cidr_blocks
  security_group_id = aws_security_group.sg[each.value.group_name].id
  from_port         = each.value.port_lower
  to_port           = each.value.port_upper
  protocol          = each.value.protocol
  description       = each.value.rule_description
}

/* SGrules for IPV6 source/dest */
resource "aws_security_group_rule" "ipv6" {
  for_each          = { for rule in local.security_group_rule_associations : format("%s-%s", rule.group_name, rule.rule_name) => rule if rule.ipv6_cidr_blocks != [] && rule.rule_name != "" }
  type              = each.value.type
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks
  security_group_id = aws_security_group.sg[each.value.group_name].id
  from_port         = each.value.port_lower
  to_port           = each.value.port_upper
  protocol          = each.value.protocol
  description       = each.value.rule_description
}

/* SGrules for SG source/dest, static SG ID */
resource "aws_security_group_rule" "sg_id" {
  for_each                 = { for rule in local.security_group_rule_associations : format("%s-%s", rule.group_name, rule.rule_name) => rule if rule.source_security_group_id != "" && rule.rule_name != "" }
  type                     = each.value.type
  source_security_group_id = each.value.source_security_group_id
  security_group_id        = aws_security_group.sg[each.value.group_name].id
  from_port                = each.value.port_lower
  to_port                  = each.value.port_upper
  protocol                 = each.value.protocol
  description              = each.value.rule_description
}

/* SGrules for SG source/dest, locally defined SG name */
resource "aws_security_group_rule" "sg_resource" {
  for_each                 = { for rule in local.security_group_rule_associations : format("%s-%s", rule.group_name, rule.rule_name) => rule if contains(keys(local.vpc_security_group_map), rule.sg_resource_name) && rule.rule_name != "" }
  type                     = each.value.type
  source_security_group_id = aws_security_group.sg[each.value.sg_resource_name].id
  security_group_id        = aws_security_group.sg[each.value.group_name].id
  from_port                = each.value.port_lower
  to_port                  = each.value.port_upper
  protocol                 = each.value.protocol
  description              = each.value.rule_description
}

/* SGrules for SG source/dest, self */
resource "aws_security_group_rule" "self" {
  for_each          = { for rule in local.security_group_rule_associations : format("%s-%s", rule.group_name, rule.rule_name) => rule if rule.self && rule.rule_name != "" }
  type              = each.value.type
  self              = true
  security_group_id = aws_security_group.sg[each.value.group_name].id
  from_port         = each.value.port_lower
  to_port           = each.value.port_upper
  protocol          = each.value.protocol
}

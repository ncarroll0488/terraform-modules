output "security_groups" {
  description = "A map of all created security groups by name"
  value = {
    for security_group_name, security_group_definition in local.vpc_security_group_map :
    security_group_name => {
      name        = security_group_name
      description = security_group_definition.description
      id          = aws_security_group.sg[security_group_name].id
      rules       = { for rule_name, rule in local.security_group_rule_associations : rule_name => rule if rule.group_name == security_group_name }
    }
  }
}

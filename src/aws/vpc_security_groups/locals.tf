locals {
  vpc_security_group_map = merge(jsondecode(var.vpc_security_group_json), var.vpc_security_group_map)
  security_group_default_conf = {
    rule_name                = "",
    rule_description         = ""
    type                     = "",
    source_security_group_id = "",
    sg_resource_name         = "",
    ipv4_cidr_blocks         = [],
    ipv6_cidr_blocks         = [],
    protocol                 = -1
    port_lower               = 0
    port_upper               = 0
    self                     = false
  }
  security_group_rule_associations = merge([
    for security_group_name, security_group_definition in local.vpc_security_group_map : { for rule in security_group_definition.rules :
      format("%s-%s", security_group_name, rule.rule_name) => merge(
        local.security_group_default_conf,
        {

          group_name        = security_group_name,
          group_description = security_group_name,
          vpc_id            = var.vpc_id,
        },
        rule
      )
    }
  ]...)
}

locals {
  gateway_services                 = toset(var.gateway_services)
  gateway_route_tables             = toset(var.gateway_route_tables)
  gateway_route_table_associations = { for a in setproduct(local.gateway_services, local.gateway_route_tables) : join("-", a) => zipmap(["service", "route_table"], a) }
  gateway_policy_associations      = { for a, b in var.gateway_policies : a => b if contains(local.gateway_services, a) }

  interface_services                    = toset(var.interface_services)
  interface_subnets                     = toset(var.interface_subnets)
  interface_security_group_ids          = toset(var.interface_security_group_ids)
  interface_subnet_associations         = { for a in setproduct(local.interface_services, local.interface_subnets) : join("-", a) => zipmap(["service", "subnet"], a) }
  interface_security_group_associations = { for a in setproduct(local.interface_services, local.interface_security_group_ids) : join("-", a) => zipmap(["service", "sg"], a) }
}

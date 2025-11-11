locals {
  routes = merge(flatten([for f_cidr in var.forward_cidrs : [for name, route_tables in var.routes : { for table in route_tables : "${name}-${table}" => { "name" = name, "route_table" = table, "cidr" = f_cidr } }]])...)
}

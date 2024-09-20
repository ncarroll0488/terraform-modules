locals {
  ip_inventory     = [for doc in var.json_documents : jsondecode(file(doc))]
  all_cidrs        = flatten([for i in local.ip_inventory : keys(i)])
  all_cidr_configs = flatten([for i in local.ip_inventory : values(i)])
  cidr_counts      = { for cidr in distinct(local.all_cidrs) : cidr => length([for x in local.all_cidrs : x if x == cidr]) }
}

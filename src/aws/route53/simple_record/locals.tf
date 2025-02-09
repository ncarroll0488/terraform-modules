locals {
  alias         = var.alias_name != ""
  alias_zone_id = coalesce(var.alias_zone_id, var.zone_id)
}

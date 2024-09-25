output "ip_inventory" {
  value       = merge(local.ip_inventory...)
  description = "A map of all allocated CIDRs and their associated tags"
}

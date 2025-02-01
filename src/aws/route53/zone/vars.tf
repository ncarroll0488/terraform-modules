variable "dns_name" {
  type = string
  description = "DNS name for the zone, such as `foo.com` or `x.y.z`"
}

variable "private_vpc_associations" {
  type = list(map(string))
  default = []
  description = "A config map of `vpc_id` and optionally `vpc_region` identifying VPCs to associate with this zone. This will make the zone private."
}

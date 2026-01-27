resource "aws_vpc_endpoint" "interface" {
  for_each            = local.interface_services
  vpc_id              = var.vpc_id
  auto_accept         = true
  private_dns_enabled = true
  service_name        = join(".", compact(concat(var.service_domains, [data.aws_region.current.region, each.value])))
  vpc_endpoint_type   = "Interface"
  tags = {
    Name = format("%s endpoint for %s", each.value, var.vpc_id)
  }
}

resource "aws_vpc_endpoint_security_group_association" "interface" {
  for_each          = local.interface_security_group_associations
  vpc_endpoint_id   = aws_vpc_endpoint.interface[each.value.service].id
  security_group_id = each.value.sg
}

resource "aws_vpc_endpoint_subnet_association" "interface" {
  for_each        = local.interface_subnet_associations
  vpc_endpoint_id = aws_vpc_endpoint.interface[each.value.service].id
  subnet_id       = each.value.subnet
}

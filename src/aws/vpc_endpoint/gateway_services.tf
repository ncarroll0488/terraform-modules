resource "aws_vpc_endpoint" "gateway" {
  for_each          = local.gateway_services
  vpc_id            = var.vpc_id
  auto_accept       = true
  service_name      = join(".", compact(concat(var.service_domains, [data.aws_region.current.region, each.value])))
  vpc_endpoint_type = "Gateway"
  tags = {
    Name = format("%s endpoint for %s", each.value, var.vpc_id)
  }
}

resource "aws_vpc_endpoint_route_table_association" "gateway" {
  for_each        = local.gateway_route_table_associations
  route_table_id  = each.value.route_table
  vpc_endpoint_id = aws_vpc_endpoint.gateway[each.value.service].id
}

resource "aws_vpc_endpoint_policy" "gateway" {
  for_each        = local.gateway_policy_associations
  vpc_endpoint_id = aws_vpc_endpoint.gateway[each.key].id
  policy          = each.value
}

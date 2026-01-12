######################################
# Configuration for AWS NAT gateways #
######################################

resource "aws_nat_gateway" "main" {
  for_each = var.nat_type == "ngw" ? local.private_subnet_definitions : {}

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${var.vpc_name} NAT ${each.key}"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route" "private" {
  for_each               = var.nat_type == "ngw" ? local.private_subnet_definitions : {}
  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[each.key].id
}

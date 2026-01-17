resource "aws_subnet" "private" {
  for_each = local.private_subnet_definitions

  vpc_id               = aws_vpc.main.id
  cidr_block           = each.value
  availability_zone_id = each.key

  tags = {
    Name = "${var.vpc_name} Private ${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = local.private_subnet_definitions

  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "Route table for ${var.vpc_name} private ${each.key}"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = local.private_subnet_definitions
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

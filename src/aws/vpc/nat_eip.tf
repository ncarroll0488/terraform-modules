resource "aws_eip" "nat" {
  for_each = local.private_subnet_definitions

  domain = "vpc"

  tags = {
    Name = "EIP for ${var.vpc_name} NAT ${each.key}"
  }
}

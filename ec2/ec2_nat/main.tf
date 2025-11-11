data "aws_ami" "amzn2023" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-minimal-*"]
  }
  filter {
    name   = "architecture"
    values = [var.gateway_instance_arch]
  }
}

resource "aws_instance" "main" {
  for_each               = var.nat_gateways
  source_dest_check      = false
  ami                    = data.aws_ami.amzn2023.id
  instance_type          = var.gateway_instance_type
  subnet_id              = each.value
  vpc_security_group_ids = toset(var.security_groups)

  user_data = templatefile("${path.module}/iptables.sh.tpl", { allowed_cidrs = toset(var.allowed_cidrs) })

  tags = merge(var.tags, { "Name" = join(" ", [var.nat_name, each.key]) })

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      ami
    ]
  }
}


resource "aws_route" "main" {
  for_each               = local.routes
  route_table_id         = each.value.route_table
  destination_cidr_block = each.value.cidr
  #network_interface_id   = module.nat_instance[each.value.name].primary_network_interface_id
  network_interface_id = aws_instance.main[each.value.name].primary_network_interface_id
}

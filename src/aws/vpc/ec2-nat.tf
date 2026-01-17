#############################
# Configuration for EC2 NAT #
#############################

data "aws_ami" "amzn2023" {
  count  = var.nat_type == "ec2" ? 1 : 0
  owners = ["amazon"]
  # most_recent ensures a non-ambiguous result, so this "always works"
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-minimal-*"]
  }
  filter {
    name   = "architecture"
    values = [var.ec2_gateway_instance_arch]
  }
}

resource "aws_iam_instance_profile" "main" {
  count       = var.nat_type == "ec2" && var.ec2_gateway_iam_role != "" ? 1 : 0
  name_prefix = "${var.vpc_name}_nat"
}

resource "aws_security_group" "ec2_nat" {
  count       = local.provision_public_subnets && var.nat_type == "ec2" ? 1 : 0
  name_prefix = "${var.vpc_name}_nat"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Security group for NAT gateways in VPC ${aws_vpc.main.id}"
  }
}

# Generally, you want your NAT to be able to reach everything, aka 0.0.0.0/0
# However, there may be cases in which a NAT should only allow access to a specific subset of IP addresses.
# The operator is allowed to override the allowed "outbound" CIDR list to a specific set of V4 CIDRs
# Note: Network ACLs are often the better option for this.
resource "aws_vpc_security_group_egress_rule" "ec2_nat" {
  for_each          = toset(local.provision_public_subnets && var.nat_type == "ec2" ? var.ec2_gateway_egress_v4_cidrs : [])
  security_group_id = aws_security_group.ec2_nat[0].id
  cidr_ipv4         = each.value
  ip_protocol       = "-1"
}

# This is the list of CIDRs allowed to forward traffic over the NAT. In nearly all cases, you want this to be
# the full list of CIDRs inside the VPC. However, some scenarios exist in which other infrastructure may
# need to make use of the NAT, perhaps from peered vpcs outside this module. Since security groups are stateful, this rule
# doesn't need anything to cover "return traffic" from the destination.

# This one is different from the rule above. Using a variable to specify the full list of CIDRs is cumbersome, since the
# operator provides it in other ways.  Instead, use coalescelist to allow the user to override the specific list of allowed CIDRs.
# The operator must necessarily have this list of addresses, so a complete override is preferable to merging values.
resource "aws_vpc_security_group_ingress_rule" "ec2_nat" {
  for_each          = toset(local.provision_public_subnets && var.nat_type == "ec2" ? coalescelist(var.ec2_gateway_ingress_v4_cidrs, local.all_cidrs) : [])
  security_group_id = aws_security_group.ec2_nat[0].id
  cidr_ipv4         = each.value
  ip_protocol       = "-1"
}

resource "aws_instance" "ec2_nat" {
  for_each = var.nat_type == "ec2" ? local.private_subnet_definitions : {}
  depends_on = [
    aws_vpc_security_group_egress_rule.ec2_nat,
    aws_vpc_security_group_ingress_rule.ec2_nat
  ]
  source_dest_check      = false
  ami                    = data.aws_ami.amzn2023[0].id
  instance_type          = var.ec2_gateway_instance_type
  subnet_id              = aws_subnet.private[each.key].id
  vpc_security_group_ids = [aws_security_group.ec2_nat[0].id] # The VPC doesn't exist prior to applying this module, so there exists no way to reference additional SGIDs.
  key_name               = var.ec2_gateway_ssh_key_name
  iam_instance_profile   = var.ec2_gateway_iam_role == "" ? null : aws_iam_instance_profile.main[0].name

  # This is the same list fed to the security group in aws_vpc_security_group_ingress_rule.ec2_nat
  user_data = templatefile("${path.module}/iptables.sh.tftpl", { allowed_cidrs = toset(coalescelist(var.ec2_gateway_ingress_v4_cidrs, local.all_cidrs)) })

  tags = { "Name" = join(" ", ["${var.vpc_name}_nat", each.key]) }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      ami
    ]
  }
}

resource "aws_eip_association" "ec2_nat" {
  for_each      = var.nat_type == "ec2" ? local.private_subnet_definitions : {}
  instance_id   = aws_instance.ec2_nat[each.key].id
  allocation_id = aws_eip.nat[each.key].id
}

resource "aws_route" "ec2_nat" {
  for_each               = var.nat_type == "ec2" ? { for x in setproduct(keys(local.private_subnet_definitions), toset(var.ec2_gateway_egress_v4_cidrs)) : "${x[0]}-${x[1]}" => { az : x[0], cidr : x[1] } } : {}
  route_table_id         = aws_route_table.private[each.value.az].id
  destination_cidr_block = each.value.cidr
  network_interface_id   = aws_instance.ec2_nat[each.value.az].primary_network_interface_id
}

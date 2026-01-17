<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.28.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.ec2_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_iam_instance_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_instance.ec2_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_internet_gateway_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway_attachment) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_association.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_rule.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.ec2_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.ec2_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_ipv4_cidr_block_association.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_vpc_security_group_egress_rule.ec2_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ec2_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_ami.amzn2023](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_cidrs"></a> [additional\_cidrs](#input\_additional\_cidrs) | Additional VPC CIDRs not otherwise specified | `list(string)` | `[]` | no |
| <a name="input_desired_availability_zones"></a> [desired\_availability\_zones](#input\_desired\_availability\_zones) | How many availability zones to use. The module will fail if there aren't enough AZs | `number` | `3` | no |
| <a name="input_ec2_gateway_egress_v4_cidrs"></a> [ec2\_gateway\_egress\_v4\_cidrs](#input\_ec2\_gateway\_egress\_v4\_cidrs) | List of CIDRs the NAT gateways are allowed to access. Only used for EC2 nat. | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_ec2_gateway_iam_role"></a> [ec2\_gateway\_iam\_role](#input\_ec2\_gateway\_iam\_role) | Specify an IAM role to associate with an iam instance profile | `string` | `""` | no |
| <a name="input_ec2_gateway_ingress_v4_cidrs"></a> [ec2\_gateway\_ingress\_v4\_cidrs](#input\_ec2\_gateway\_ingress\_v4\_cidrs) | List of CIDRs allowed to forward traffic over the NAT. If left empty, this will allow all VPC CIDRs. Only used in EC2 nat. | `list(string)` | `[]` | no |
| <a name="input_ec2_gateway_instance_arch"></a> [ec2\_gateway\_instance\_arch](#input\_ec2\_gateway\_instance\_arch) | Arch of the NAT instance, used in AMI lookup. | `string` | `"arm64"` | no |
| <a name="input_ec2_gateway_instance_type"></a> [ec2\_gateway\_instance\_type](#input\_ec2\_gateway\_instance\_type) | Instance type used for the NAT | `string` | `"t4g.nano"` | no |
| <a name="input_ec2_gateway_ssh_key_name"></a> [ec2\_gateway\_ssh\_key\_name](#input\_ec2\_gateway\_ssh\_key\_name) | SSH Keypair used by the nat instances | `string` | `""` | no |
| <a name="input_ignore_availability_zone_ids"></a> [ignore\_availability\_zone\_ids](#input\_ignore\_availability\_zone\_ids) | Ignore these availability zones. Note that changing this setting may result in lots of resources being replaced | `list(string)` | `[]` | no |
| <a name="input_internal_nacl_rules"></a> [internal\_nacl\_rules](#input\_internal\_nacl\_rules) | Custom NACL rules. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule for parameters. | `map(any)` | `{}` | no |
| <a name="input_internal_subnet_cidr"></a> [internal\_subnet\_cidr](#input\_internal\_subnet\_cidr) | Provision the internal subnets from this CIDR. | `string` | `""` | no |
| <a name="input_nat_type"></a> [nat\_type](#input\_nat\_type) | Pick the type of NAT used. Allowed values, `ec2`, `ngw` | `string` | `"ngw"` | no |
| <a name="input_pad_cidrs"></a> [pad\_cidrs](#input\_pad\_cidrs) | Leave gaps between unused availabiity zones and subnet classes. | `bool` | `true` | no |
| <a name="input_primary_cidr"></a> [primary\_cidr](#input\_primary\_cidr) | Primary VPC CIDR | `string` | n/a | yes |
| <a name="input_private_nacl_rules"></a> [private\_nacl\_rules](#input\_private\_nacl\_rules) | Custom NACL rules. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule for parameters. | `map(any)` | `{}` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | Provision the private subnets from this CIDR. | `string` | `""` | no |
| <a name="input_provision_internal_subnets"></a> [provision\_internal\_subnets](#input\_provision\_internal\_subnets) | Enables provisioning of internal subnets, which do not have internet access | `bool` | `false` | no |
| <a name="input_provision_private_subnets"></a> [provision\_private\_subnets](#input\_provision\_private\_subnets) | Enables provisioning of private subnets, which use a NGW to get to the internet. This also enables public subnets | `bool` | `false` | no |
| <a name="input_provision_public_subnets"></a> [provision\_public\_subnets](#input\_provision\_public\_subnets) | Enables provisioning of public subnets, which use an IGW to get to the internet | `bool` | `false` | no |
| <a name="input_public_nacl_rules"></a> [public\_nacl\_rules](#input\_public\_nacl\_rules) | Custom NACL rules. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule for parameters. | `map(any)` | `{}` | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | Provision the public subnets from this CIDR. | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC. Used in tags | `string` | `"Main VPC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internal_route_tables"></a> [internal\_route\_tables](#output\_internal\_route\_tables) | Route tables used in internal subnets |
| <a name="output_internal_subnets"></a> [internal\_subnets](#output\_internal\_subnets) | All subnets in the internal routing class, by AZ |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | IDs of the NAT gateway resources/instances by AZ |
| <a name="output_nat_gateway_ips"></a> [nat\_gateway\_ips](#output\_nat\_gateway\_ips) | IPv4 addresses assigned to NAT gateways |
| <a name="output_private_route_tables"></a> [private\_route\_tables](#output\_private\_route\_tables) | Route tables used in private subnets |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | All subnets in the private routing class, by AZ |
| <a name="output_public_route_table"></a> [public\_route\_table](#output\_public\_route\_table) | Public route table, if used |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | All subnets in the public routing class, by AZ |
| <a name="output_vpc_cidrs"></a> [vpc\_cidrs](#output\_vpc\_cidrs) | CIDRs attached to the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC |
<!-- END_TF_DOCS -->


## About
This module attempts provide boilerplate configuration of a VPC. It is not meant to encompass every single feature of a VPC, but rather to provide the operator with a functional, customizable resource.

## Usage
### Quick Start
A typical configuration looks like this
```hcl
provision_public_subnets = true
provision_private_subnets = true
primary_cidr = "203.0.113.0/24"  # Required
vpc_name = "my_vpc"
```
This provisions a 3 AZ VPC with IGW and NAT for their respective subnets, and the accompanying route tables.

### Routing
In order to have any real networking, at least one of the following booleans must be enabled:

* `provision_public_subnets` : For accessing the internet via IGW
* `provision_private_subnets` : For accessing the internet via NGW (implies public as well)
* `provision_internal_subnets` : For no internet access

When any of these settings are enabled, the module will create `desired_availability_zones` number of subnets of each type. For instance, the default AZ count is 3, so if you enable only `provision_public_subnets`, you will get 3 subnets using an IGW as their default route, spread across the first three listed AZs.

Note that enabling private networking also enables public networking, as NAT gateways must themselves route through IGW. One NAT gateway per availability zone is created when using private networking. This allows outbound traffic to stay within a single AZ, which is more fault tolerant when entire AZs go down.

## CIDR splitting
A key feature of this module handles the splitting of a CIDR to even-sized parts. Accommodations are made to allow availability zones to be "slotted" into an existing VPC. The operator of this module does not have to think about how to break apart a CIDR, or do any awkward IP mathematics.

Right-sized subnet CIDRs are determined by first calculating the total number of possible availability zones, and multiplying it by 3 (three types of routing: public, private, internal). Next we, get the ceiling of the log-base-2 of that number. This yields the number of bits which are added to the provided CIDR netmask when provisioning a subnet.

As an example, If we have 4 availability zones, that means up to 12 CIDRs are needed to accommodate all possible subnet configurations. log-base-2 of 12 is ~ 3.58, which rounds up to 4 (we always round up).

If we provided a VPC CIDR `203.0.113.0/24`, that means each subnet will have a CIDR of size `/28`. The individual CIDR assignments are done sequentially, starting "left to right" through availability zones, and then "top to bottom" in the order public, private, internal.

| Network Type | az1 | az2 | az3 | az4 |
| :--- | :--- | :--- | :--- | :--- |
| **public** | 203.0.113.0/28 | 203.0.113.16/28 | 203.0.113.32/28 | 203.0.113.48/28 |
| **private** | 203.0.113.64/28 | 203.0.113.80/28 | 203.0.113.96/28 | 203.0.113.112/28 |
| **internal** | 203.0.113.128/28 | 203.0.113.144/28 | 203.0.113.160/28 | 203.0.113.176/28 |

Note that in this example, some unused space is remaining at the "end" of the VPC starting at `203.0.113.192`.

## NAT Gateway types
By default, this module provisions AWS NAT gateways to handle the egress of traffic from private subnets to the internet. However, the variable `nat_type` can be set to `ec2` to use EC2 instances running amazon linux and iptables to handle NAT. This is cheaper than using AWS NAT, but is less fault tolerant.

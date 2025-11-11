# ec2-nat
Manages ec2 instances which handle NAT traffic. This may be a cheaper alternative to NAT gateways for fault-tolerant workloads.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_iam_instance_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_ami.amzn2023](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocate_eip"></a> [allocate\_eip](#input\_allocate\_eip) | Allocate EIPs for the NATs. You may wish to turn this off for NAT inside a private network | `bool` | `true` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | CIDRs allowed to send traffic through the NAT. This is used in iptables config and the security group | `list(string)` | n/a | yes |
| <a name="input_forward_cidrs"></a> [forward\_cidrs](#input\_forward\_cidrs) | CIDRs which will be forwarded over the NAT | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_gateway_instance_arch"></a> [gateway\_instance\_arch](#input\_gateway\_instance\_arch) | Arch of the NAT instance, used in AMI lookup. | `string` | `"arm64"` | no |
| <a name="input_gateway_instance_type"></a> [gateway\_instance\_type](#input\_gateway\_instance\_type) | Instance type used for the NAT | `string` | `"t4g.nano"` | no |
| <a name="input_iam_role"></a> [iam\_role](#input\_iam\_role) | Name of an optional IAM role to associate with the NAT instances | `string` | `""` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH Keypair used by the nat hosts | `string` | `null` | no |
| <a name="input_nat_gateways"></a> [nat\_gateways](#input\_nat\_gateways) | A map of name => subnet | `map(string)` | n/a | yes |
| <a name="input_nat_name"></a> [nat\_name](#input\_nat\_name) | NAT name used in tags | `string` | `"NAT"` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A map of NAT name => [route tables] | `map(list(string))` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | External security groups to add to the NATs | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_arns"></a> [instance\_arns](#output\_instance\_arns) | ARNs of the NAT gateway instances, by name |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | IDs of the NAT gateway instances, by name |
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | Name of the instance profile, if a role was provided |
| <a name="output_private_ips"></a> [private\_ips](#output\_private\_ips) | Private IPs of the NAT gateway instances, by name |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | NAT Gateway public IPs by name |
<!-- END_TF_DOCS -->
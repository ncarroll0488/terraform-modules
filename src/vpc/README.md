## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_cidrs | Additional VPC CIDRs not otherwise specified | `list(string)` | `[]` | no |
| desired\_availability\_zones | How many availability zones to use. The module will fail if there aren't enough AZs | `number` | `3` | no |
| ignore\_availability\_zone\_ids | Ignore these availability zones. Note that changing this setting may result in lots of resources being replaced | `list(string)` | `[]` | no |
| internal\_subnet\_cidr | Provision the internal subnets from this CIDR. | `string` | `""` | no |
| pad\_cidrs | Leave gaps between unused availabiity zones and subnet classes. | `bool` | `true` | no |
| primary\_cidr | Primary VPC CIDR | `string` | n/a | yes |
| private\_subnet\_cidr | Provision the private subnets from this CIDR. | `string` | `""` | no |
| provision\_internal\_subnets | Enables provisioning of internal subnets, which do not have internet access | `bool` | `false` | no |
| provision\_private\_subnets | Enables provisioning of private subnets, which use a NGW to get to the internet. This also enables public subnets | `bool` | `false` | no |
| provision\_public\_subnets | Enables provisioning of public subnets, which use an IGW to get to the internet | `bool` | `false` | no |
| public\_subnet\_cidr | Provision the public subnets from this CIDR. | `string` | `""` | no |
| vpc\_name | Name of the VPC. Used in tags | `string` | `"Main VPC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| internal\_route\_tables | Route tables used in internal subnets |
| internal\_subnets | All subnets in the internal routing class, by AZ |
| private\_route\_tables | Route tables used in private subnets |
| private\_subnets | All subnets in the private routing class, by AZ |
| public\_route\_table | Public route table, if used |
| public\_subnets | All subnets in the public routing class, by AZ |
| vpc\_id | ID of the VPC |


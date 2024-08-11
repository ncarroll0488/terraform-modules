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

## About
This module attempts provide boilerplate configuration of a VPC. It is not meant to encompass every single feature of a VPC, but rather to provide the operator with a functional, customizable resource.

## Usage
### Just tell me how to configure it
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

As an example, If we have 4 availability zones, that means up to 12 CIDRs are needed to accommodate all possible subnet configurations. log-base-2 of 12 is ~ 3.58, which round up to 4 (we always round up).

If we provided a CIDR `203.0.113.0/24`, that means each subnet will have a CIDR of size `/28`. The individual CIDR assignments are done sequentially, starting "left to right" through availability zones, and then "top to bottom" in the order public, private, internal.

Note that in this example, some unused space is remaining at the "end" of the VPC starting at `203.0.113.192`.

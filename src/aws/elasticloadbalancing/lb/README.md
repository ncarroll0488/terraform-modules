## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs\_bucket | Bucket used to store access logs | `string` | `""` | no |
| access\_logs\_prefix | Path prefix for access log storage | `string` | `null` | no |
| client\_keep\_alive | Client keep alive value in seconds. The valid range is 60-604800 seconds. The default is 3600 seconds. | `number` | `null` | no |
| connection\_logs\_bucket | Bucket used to store connection logs | `string` | `""` | no |
| connection\_logs\_prefix | Path prefix for connection log storage | `string` | `null` | no |
| customer\_owned\_ipv4\_pool | Customer IP pool for this LB | `string` | `null` | no |
| desync\_mitigation\_mode | How the load balancer handles requests that might pose a security risk to an application due to HTTP desync. | `string` | `null` | no |
| dns\_record\_client\_routing\_policy | How traffic is distributed among the load balancer Availability Zones | `string` | `null` | no |
| drop\_invalid\_header\_fields | Remove invalid headers from the request | `bool` | `null` | no |
| eip\_mappings | A map of subnet\_id => eipalloc | `map(string)` | `{}` | no |
| enable\_access\_logs | Toggle access logs | `string` | `null` | no |
| enable\_connection\_logs | Toggle connection logs | `string` | `null` | no |
| enable\_cross\_zone\_load\_balancing | Enable coss-zone load balancing. Always on for application LBs | `bool` | `null` | no |
| enable\_deletion\_protection | Enable deletion protection. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#enable_deletion_protection-4 | `bool` | `true` | no |
| enable\_http2 | Enable HTTP/2 | `bool` | `null` | no |
| enable\_zonal\_shift | Enable zonal shift | `bool` | `null` | no |
| internal | Make this an internal LB | `bool` | `null` | no |
| ip\_address\_type | Type of IP addresses to use | `string` | `null` | no |
| lb\_name | Name of the LB | `string` | n/a | yes |
| lb\_type | Type of the LB | `string` | `"application"` | no |
| preserve\_host\_header | Preserve the HTTP Host header | `bool` | `null` | no |
| security\_groups | Security groups IDs to use on this load balancer | `list(string)` | `null` | no |
| subnet\_ids | List of subnets into which the load balancer is placed | `list(string)` | n/a | yes |
| tags | A map of tags | `map(string)` | `{}` | no |
| xff\_header\_processing\_mode | Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| lb\_arn | ARN of the load balancer |
| lb\_arn\_suffix | LB ARN suffix |
| lb\_dns\_name | The DNS hostname of the LB - for CNAMEs, etc. |
| lb\_zone\_id | Zone ID of the load balancer's Route53 records (for aliases) |


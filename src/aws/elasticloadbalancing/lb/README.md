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
| https\_redirect | When using application load balancing, add a relatively common listener which redirects to https | `bool` | `false` | no |
| https\_redirect\_from\_port | The listening port which will redirect traffic to HTTPS | `number` | `80` | no |
| https\_redirect\_to\_port | HTTPS redirect will be sent to this port | `number` | `443` | no |
| internal | Make this an internal LB | `bool` | `null` | no |
| ip\_address\_type | Type of IP addresses to use | `string` | `null` | no |
| lb\_name | Name of the LB | `string` | n/a | yes |
| lb\_type | Type of the LB | `string` | `"application"` | no |
| listener\_forwarding | A quick-and-easy way to bind a listener to an IP target group. For more advanced behavior, use this module's outputs in a separate module which offers more complex features | `map(any)` | `{}` | no |
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
| target\_group\_arns | n/a |


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.redirect_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.nlb_to_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_bucket"></a> [access\_logs\_bucket](#input\_access\_logs\_bucket) | Bucket used to store access logs | `string` | `""` | no |
| <a name="input_access_logs_prefix"></a> [access\_logs\_prefix](#input\_access\_logs\_prefix) | Path prefix for access log storage | `string` | `null` | no |
| <a name="input_client_keep_alive"></a> [client\_keep\_alive](#input\_client\_keep\_alive) | Client keep alive value in seconds. The valid range is 60-604800 seconds. The default is 3600 seconds. | `number` | `null` | no |
| <a name="input_connection_logs_bucket"></a> [connection\_logs\_bucket](#input\_connection\_logs\_bucket) | Bucket used to store connection logs | `string` | `""` | no |
| <a name="input_connection_logs_prefix"></a> [connection\_logs\_prefix](#input\_connection\_logs\_prefix) | Path prefix for connection log storage | `string` | `null` | no |
| <a name="input_customer_owned_ipv4_pool"></a> [customer\_owned\_ipv4\_pool](#input\_customer\_owned\_ipv4\_pool) | Customer IP pool for this LB | `string` | `null` | no |
| <a name="input_desync_mitigation_mode"></a> [desync\_mitigation\_mode](#input\_desync\_mitigation\_mode) | How the load balancer handles requests that might pose a security risk to an application due to HTTP desync. | `string` | `null` | no |
| <a name="input_dns_record_client_routing_policy"></a> [dns\_record\_client\_routing\_policy](#input\_dns\_record\_client\_routing\_policy) | How traffic is distributed among the load balancer Availability Zones | `string` | `null` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | Remove invalid headers from the request | `bool` | `null` | no |
| <a name="input_eip_mappings"></a> [eip\_mappings](#input\_eip\_mappings) | A map of subnet\_id => eipalloc | `map(string)` | `{}` | no |
| <a name="input_enable_access_logs"></a> [enable\_access\_logs](#input\_enable\_access\_logs) | Toggle access logs | `string` | `null` | no |
| <a name="input_enable_connection_logs"></a> [enable\_connection\_logs](#input\_enable\_connection\_logs) | Toggle connection logs | `string` | `null` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | Enable coss-zone load balancing. Always on for application LBs | `bool` | `null` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable deletion protection. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#enable_deletion_protection-4 | `bool` | `true` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Enable HTTP/2 | `bool` | `null` | no |
| <a name="input_enable_zonal_shift"></a> [enable\_zonal\_shift](#input\_enable\_zonal\_shift) | Enable zonal shift | `bool` | `null` | no |
| <a name="input_https_redirect"></a> [https\_redirect](#input\_https\_redirect) | When using application load balancing, add a relatively common listener which redirects to https | `bool` | `false` | no |
| <a name="input_https_redirect_from_port"></a> [https\_redirect\_from\_port](#input\_https\_redirect\_from\_port) | The listening port which will redirect traffic to HTTPS | `number` | `80` | no |
| <a name="input_https_redirect_to_port"></a> [https\_redirect\_to\_port](#input\_https\_redirect\_to\_port) | HTTPS redirect will be sent to this port | `number` | `443` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Make this an internal LB | `bool` | `null` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | Type of IP addresses to use | `string` | `null` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Name of the LB | `string` | n/a | yes |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | Type of the LB | `string` | `"application"` | no |
| <a name="input_listener_forwarding"></a> [listener\_forwarding](#input\_listener\_forwarding) | A quick-and-easy way to bind a listener to an IP target group. For more advanced behavior, use this module's outputs in a separate module which offers more complex features | `map(any)` | `{}` | no |
| <a name="input_preserve_host_header"></a> [preserve\_host\_header](#input\_preserve\_host\_header) | Preserve the HTTP Host header | `bool` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups IDs to use on this load balancer | `list(string)` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets into which the load balancer is placed | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_xff_header_processing_mode"></a> [xff\_header\_processing\_mode](#input\_xff\_header\_processing\_mode) | Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | ARN of the load balancer |
| <a name="output_lb_arn_suffix"></a> [lb\_arn\_suffix](#output\_lb\_arn\_suffix) | LB ARN suffix |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS hostname of the LB - for CNAMEs, etc. |
| <a name="output_lb_zone_id"></a> [lb\_zone\_id](#output\_lb\_zone\_id) | Zone ID of the load balancer's Route53 records (for aliases) |
| <a name="output_target_group_arns"></a> [target\_group\_arns](#output\_target\_group\_arns) | n/a |
<!-- END_TF_DOCS -->
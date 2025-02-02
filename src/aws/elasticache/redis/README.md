## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Identifier for the redis cluster | `string` | n/a | yes |
| engine\_version | Engine version | `string` | n/a | yes |
| node\_type | The node type to use for redis. See https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/CacheNodes.SupportedTypes.html | `string` | n/a | yes |
| num\_cache\_nodes | The number of cache nodes to use in the cluster | `number` | `1` | no |
| parameter\_group\_name | Name of the redis parameter group | `string` | n/a | yes |
| redis\_port | The port redis will listen on | `number` | `6379` | no |
| security\_group\_ids | Security group IDs to use | `list(string)` | n/a | yes |
| subnet\_ids | Subnet IDs to put into the cluster's subnet group | `list(string)` | n/a | yes |
| tags | Map of tags | `map(string)` | `{}` | no |
| transit\_encryption\_enabled | Enable encrypted connections | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| cache\_nodes | List of node objects including id, address, port and availability\_zone |
| cluster\_arn | ARN of the cluster |


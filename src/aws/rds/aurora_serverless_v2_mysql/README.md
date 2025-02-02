## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the DB cluster | `string` | n/a | yes |
| db\_name | Default DB name | `string` | `"main"` | no |
| db\_pause\_timer | The DB will pause after this many seconds of inactivity | `number` | `3600` | no |
| engine\_version | Version of the engine to use. | `string` | n/a | yes |
| instance\_count | The number of serverless instances in the cluster | `number` | `1` | no |
| kms\_key\_id | KMS key to use for encryption | `string` | `null` | no |
| master\_password\_kms\_key | KMS key to use for the master password | `string` | `null` | no |
| master\_username | Master username | `string` | `"main"` | no |
| max\_db\_capacity | Maximum DB capacity units for serverless nodes | `number` | `1` | no |
| min\_db\_capacity | Minimum DB capacity units for serverless nodes | `number` | `0` | no |
| security\_group\_ids | Security groups to give to the DB cluster | `list(string)` | n/a | yes |
| subnet\_ids | DB instances will live in these subnets | `list(string)` | n/a | yes |
| tags | Tags to add to the cluster's resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | ARN of the cluster |
| cluster\_identifier | ID of the cluster |
| endpoint | DNS name of the cluster |
| master\_user\_secret | Information about the master secret |
| master\_username | Master username |


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocated\_storage | Initial storage size | `string` | `10` | no |
| db\_name | Default DB name | `string` | `"main"` | no |
| db\_pause\_timer | The DB will pause after this many seconds of inactivity | `number` | `3600` | no |
| engine\_version | Version of the engine to use. | `string` | n/a | yes |
| final\_snapshot\_identifier | Indentifier for the final snapshot, on delete | `string` | `""` | no |
| instance\_class | Type of the main instance | `string` | n/a | yes |
| instance\_identifier | ID of the instances | `string` | n/a | yes |
| kms\_key\_id | KMS key to use for encryption | `string` | `null` | no |
| master\_password\_kms\_key | KMS key to use for the master password | `string` | `null` | no |
| master\_username | Master username | `string` | `"main"` | no |
| max\_allocated\_storage | Maximum size for storage autoscaling | `string` | `20` | no |
| max\_db\_capacity | Maximum DB capacity units for serverless nodes | `number` | `1` | no |
| min\_db\_capacity | Minimum DB capacity units for serverless nodes | `number` | `0` | no |
| replica\_instance\_class | Type of the replica instances. Leave blank to default to the main instance's type | `string` | `""` | no |
| replicas | The amount of replicas to create | `number` | `0` | no |
| security\_group\_ids | Security groups to give to the DB cluster | `list(string)` | n/a | yes |
| skip\_final\_snapshot | Skip final snapshot on delete | `bool` | `false` | no |
| subnet\_ids | DB instances will live in these subnets | `list(string)` | n/a | yes |
| tags | Tags to add to the cluster's resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | DNS name of the cluster |
| master\_user\_secret | Information about the master secret |


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| log\_group\_class | Type of log group storage. Must be one of `STANDARD`, `INFREQUENT_ACCESS` | `string` | `"STANDARD"` | no |
| log\_group\_kms\_key\_id | KMS Key to use to encrypt logs | `string` | `null` | no |
| log\_group\_name | Name prefix of the log group. | `string` | n/a | yes |
| log\_group\_retention\_in\_days | Number of days to retain logs | `number` | `90` | no |
| log\_group\_skip\_destroy | Skip destroying of the log group when deleting resources | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| log\_group\_arn | ARN of the log group |
| log\_group\_kms\_key\_id | ARN of the KMS key used to encrypt logs |
| log\_group\_name | Name of the log group |


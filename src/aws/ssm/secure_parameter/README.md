## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kms\_key\_arn | ARN of the KMS key used to encrypt this secret | `string` | `null` | no |
| parameter\_name | Name of the parameter | `string` | n/a | yes |
| password\_min\_length | Length of the password | `number` | `32` | no |

## Outputs

| Name | Description |
|------|-------------|
| set\_value\_command | Run this command to set the value of the secret |
| ssm\_parameter\_arn | ARN of the SSM parameter |
| ssm\_parameter\_name | Name of the SSM parameter |


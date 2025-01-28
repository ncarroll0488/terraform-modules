## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ecr\_repo\_name | Name of the repo | `string` | n/a | yes |
| encryption\_type | The type of encryption to use | `string` | `""` | no |
| image\_scanning\_enabled | Enables automated scanning of images on push | `bool` | `true` | no |
| image\_tag\_mutability | Set to False for immutable tags | `bool` | `false` | no |
| kms\_key\_arn | ARN of a KMS key used to encrypt this repo | `string` | `""` | no |
| kms\_key\_rotation\_days | Interval of KMS key rotation, in days | `number` | `null` | no |
| use\_aws\_managed\_kms | Enable this to use aws-managed KMS keys for encryption, rather than creating one | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecr\_repo\_arn | The ARN of the repo |
| ecr\_repo\_name | Name of the repo |
| ecr\_repo\_url | The URL of the repo, for docker, etc |
| kms\_key\_arn | ARN of the KMS key created for this repo |


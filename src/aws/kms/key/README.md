## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_key\_store\_id | ID of the KMS Custom Key Store where the key will be stored | `string` | `null` | no |
| customer\_master\_key\_spec | n/a | `string` | `"ENCRYPT_DECRYPT"` | no |
| enable\_key | Enable this key | `bool` | `true` | no |
| key\_deletion\_window | Deletion window of the key, in days | `number` | `null` | no |
| key\_names | A list of key aliases to create | `list(string)` | n/a | yes |
| key\_rotation\_days | How frequently the key is rotated, in days | `number` | `-1` | no |
| key\_usage | Intended use of the key | `string` | `"ENCRYPT_DECRYPT"` | no |
| kms\_key\_description | Description of this KMS key | `string` | n/a | yes |
| multi\_region | Make this a multi\_region key | `bool` | `true` | no |
| tags | Map of tags for this key | `map(string)` | `{}` | no |
| xks\_key\_id | Identifies the external key that serves as key material for the KMS key | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| kms\_key\_aliases | Aliases assigned to this key |
| kms\_key\_arn | ARN of the key |
| kms\_key\_id | AWS UID of the key |


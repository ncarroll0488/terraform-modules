## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_log\_group\_arns | ARNs of log groups to be included in policies | `list(string)` | `[]` | no |
| ecr\_repo\_arns | List of ECR Repos ARNs accessible by these roles. Defaults to [\*] | `list(string)` | `[]` | no |
| ecs\_cluster\_arns | List of cluster ARNs in which these roles can run tasks | `list(string)` | `[]` | no |
| iam\_entity\_path | Put IAM entities under this path | `string` | `null` | no |
| kms\_key\_arns | KMS Key IDs which will be used for encrypt/decrypt | `list(string)` | `[]` | no |
| role\_name | Name of the roles created in this module | `string` | n/a | yes |
| secret\_arns | List of secret ARNs this role will be able to access | `list(string)` | `[]` | no |
| ssm\_parameter\_arns | List of SSM parameter ARNs this role will be able to acces | `list(string)` | `[]` | no |
| task\_definition\_arns | Restrict the service role to these task definition ARNs. | `list(string)` | `[]` | no |
| task\_role\_policies | A list of policy ARNs to attach to the task role | `list(string)` | `[]` | no |
| vpc\_ids | IDs of vpcs where tasks are allowed to run. Leaving this empty means unrestricted placement | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| execution\_role\_arn | ARN of the execution role |
| service\_role\_arn | ARN of the service role |
| task\_role\_arn | ARN of the task role |


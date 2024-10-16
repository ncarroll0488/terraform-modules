## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the cluster, used in tagging and IAM elements | `string` | n/a | yes |
| container\_insights | Enabled container insights | `bool` | `true` | no |
| ecr\_repos | List of ECR Repos accessible by this cluster. Defaults to \* | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| iam\_entity\_path | Put IAM entities under this path | `string` | `null` | no |
| task\_definition\_arns | Restrict the service role to these task definition ARNs | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| task\_role\_policies | A list of policy ARNs to attach to the task role | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_log\_group\_arn | ARN of the cluster's cloudwatch log group |
| ecs\_cluster\_arn | ARN of the ECS Cluster |
| execution\_role\_arn | ARN of the execution role |
| service\_role\_arn | ARN of the service role |
| task\_role\_arn | ARN of the task role |


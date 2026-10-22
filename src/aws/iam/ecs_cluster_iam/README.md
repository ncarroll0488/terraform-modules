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
| [aws_iam_policy.events_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.events_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_arn.clusters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_iam_policy_document.events_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.events_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.execution_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.service_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_group_arns"></a> [cloudwatch\_log\_group\_arns](#input\_cloudwatch\_log\_group\_arns) | ARNs of log groups to be included in policies | `list(string)` | `[]` | no |
| <a name="input_ecr_repo_arns"></a> [ecr\_repo\_arns](#input\_ecr\_repo\_arns) | List of ECR Repos ARNs accessible by these roles. Defaults to [*] | `list(string)` | `[]` | no |
| <a name="input_ecs_cluster_arns"></a> [ecs\_cluster\_arns](#input\_ecs\_cluster\_arns) | List of cluster ARNs in which these roles can run tasks | `list(string)` | `[]` | no |
| <a name="input_iam_entity_path"></a> [iam\_entity\_path](#input\_iam\_entity\_path) | Put IAM entities under this path | `string` | `null` | no |
| <a name="input_kms_key_arns"></a> [kms\_key\_arns](#input\_kms\_key\_arns) | KMS Key IDs which will be used for encrypt/decrypt | `list(string)` | `[]` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of a permission boundary policy to apply to the task, service, execurtion, and eventbridge roles | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the roles created in this module | `string` | n/a | yes |
| <a name="input_secret_arns"></a> [secret\_arns](#input\_secret\_arns) | List of secret ARNs this role will be able to access | `list(string)` | `[]` | no |
| <a name="input_ssm_parameter_arns"></a> [ssm\_parameter\_arns](#input\_ssm\_parameter\_arns) | List of SSM parameter ARNs this role will be able to acces | `list(string)` | `[]` | no |
| <a name="input_task_definition_arns"></a> [task\_definition\_arns](#input\_task\_definition\_arns) | Restrict the service role to these task definition ARNs. | `list(string)` | `[]` | no |
| <a name="input_task_roles"></a> [task\_roles](#input\_task\_roles) | A map of role => config. Currently supported config fields: `policies` | <pre>map(object({<br/>    policies             = optional(list(string), []),<br/>    permissions_boundary = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | IDs of vpcs where tasks are allowed to run. Leaving this empty means unrestricted placement | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | ARN of the execution role |
| <a name="output_service_role_arn"></a> [service\_role\_arn](#output\_service\_role\_arn) | ARN of the service role |
| <a name="output_task_role_arns"></a> [task\_role\_arns](#output\_task\_role\_arns) | ARN of the task role |
<!-- END_TF_DOCS -->
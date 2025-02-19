## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assign\_public\_ip | Whether to assign a public IP address to the service task (required for Fargate). | `bool` | `false` | no |
| cluster\_id | The ECS cluster where the service will run. | `string` | n/a | yes |
| deployment\_maximum\_percent | The upper limit on the number of running tasks during a deployment. | `number` | `200` | no |
| deployment\_minimum\_healthy\_percent | The lower limit on the number of running tasks during a deployment. | `number` | `100` | no |
| desired\_count | The number of instances of the task to run in the service. | `number` | `1` | no |
| force\_new\_deployment | Whether to force a new deployment of the ECS service. | `bool` | `false` | no |
| health\_check\_grace\_period\_seconds | The amount of time to ignore failing health checks after a task has been started. | `number` | `60` | no |
| launch\_type | The launch type on which to run the service. Possible values: EC2 or FARGATE. | `string` | n/a | yes |
| lb\_associations | list of maps containing `target_group_arn`, `container_name`, `container_port` | `list(map(string))` | `[]` | no |
| security\_groups | A list of security group IDs to assign to the ECS service. | `list(string)` | n/a | yes |
| service\_name | The name of the ECS service. | `string` | n/a | yes |
| subnets | A list of subnet IDs for the ECS service to use in the VPC. | `list(string)` | n/a | yes |
| tags | A map of tags to assign to the ECS service. | `map(string)` | `{}` | no |
| task\_definition | The task definition ARN to associate with the service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service\_arn | The ARN of the ECS service. |
| service\_name | The name of the ECS service. |


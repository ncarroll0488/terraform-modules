## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| container\_definitions | A valid JSON string for the container definitions. | `string` | n/a | yes |
| cpu | The number of CPU units to reserve for the task. | `string` | n/a | yes |
| cpu\_architecture | The task's CPU arch | `string` | n/a | yes |
| execution\_role\_arn | The ARN of the IAM role that Amazon ECS can assume to pull container images. | `string` | n/a | yes |
| family | The name of the family for this task definition. | `string` | n/a | yes |
| memory | The amount of memory (in MiB) to reserve for the task. | `string` | n/a | yes |
| network\_mode | The Docker networking mode to use for the containers in the task. | `string` | `"awsvpc"` | no |
| operating\_system\_family | The task's operating system | `string` | n/a | yes |
| region | The AWS region to deploy the task definition. | `string` | n/a | yes |
| requires\_compatibilities | A list of launch types required by the task. | `list(string)` | n/a | yes |
| runtime\_platform | The platform for the task to run on (Linux or Windows). | `string` | `"LINUX"` | no |
| tags | A map of tags to assign to the task definition. | `map(string)` | `{}` | no |
| task\_role\_arn | The ARN of the IAM role that grants permissions to the task. | `string` | n/a | yes |
| volumes | A list of volume mounts which contain `volume_name`, `efs_file_system_id`, and `host_path`. Optionally, `efs_root_directory` can be added to select a subdirectory of your EFS share | `list(object({}))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| task\_definition\_arn | The ARN of the created ECS Task Definition. |
| task\_definition\_family | The family of the ECS Task Definition. |


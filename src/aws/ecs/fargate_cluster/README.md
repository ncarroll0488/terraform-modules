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

## Outputs

| Name | Description |
|------|-------------|
| ecs\_cluster\_arn | ARN of the ECS Cluster |


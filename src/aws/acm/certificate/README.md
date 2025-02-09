## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain\_name | Domain name for the cert | `string` | n/a | yes |
| domain\_validation\_zones | A map of domain name => zone ID for auto-populating route53 validation records | `map(string)` | `{}` | no |
| subject\_alternative\_names | A list of extra DNS names | `list(string)` | `[]` | no |
| tags | Extra tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | ARN of the certificate |
| domain\_validation\_options | n/a |


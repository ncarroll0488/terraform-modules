## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias\_eval\_target\_health | Enable to evaluate alias target health | `bool` | `false` | no |
| alias\_name | Alias target. This changes the record to an alias when set | `string` | `""` | no |
| alias\_zone\_id | The hosted zone ID of your alias record. Leave blank to use var.zone\_id | `string` | `""` | no |
| record\_name | Name of record, like foo.bar.com | `string` | n/a | yes |
| record\_type | Type of the record, like A, NS, TXT, etc | `string` | `"A"` | no |
| record\_values | A list of values for the record, such as an IP address for an A record | `list(string)` | `[]` | no |
| ttl | TTL of the record | `number` | `300` | no |
| zone\_id | ID of the zone into which records are placed | `string` | n/a | yes |

## Outputs

No output.


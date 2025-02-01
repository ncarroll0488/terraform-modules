## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_name | DNS name for the zone, such as `foo.com` or `x.y.z` | `string` | n/a | yes |
| private\_vpc\_associations | A config map of `vpc_id` and optionally `vpc_region` identifying VPCs to associate with this zone. This will make the zone private. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| ns\_records | Nameserver records |


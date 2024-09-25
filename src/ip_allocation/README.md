## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| external | n/a |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_duplicate\_cidrs | Allow duplicate CIDRs | `bool` | `false` | no |
| allow\_overlapping\_cidrs | Allow CIDRs with overlapping ranges | `bool` | `false` | no |
| json\_documents | JSON documents to load and parse | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ip\_inventory | A map of all allocated CIDRs and their associated tags |

This module attempts to provide a global, authoritative list of assigned IP addresses used in VPCs. The datasource is simple JSON and the format is relatively freeform. It's a dictionary of dictionaries. The key of each dictionary is a CIDR, and the values are the filtering criteria. No specific set of keys are needed, however the module will attempt to check for duplicates.

```json
{
  "203.0.113.0/24": {
      "account": "1111222233334444",
      "env": "demo",
      "region": "us-east-2",
      "vpcname": "demo1"
  }
}
```

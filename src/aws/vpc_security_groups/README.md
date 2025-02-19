## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc\_id | VPC ID to attach security groups to | `string` | n/a | yes |
| vpc\_security\_group\_json | A json blob of SG rules. Used to overcome data type issues interragrunt | `string` | `"{}"` | no |
| vpc\_security\_group\_map | A map of SG rules | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| security\_groups | A map of all created security groups by name |

Defines security groups in an easily-readable heirarchical format.

### `vpc_security_group_map`
This contains a `name => config` map of one or more rules. Example: 
```hcl
"some_rule" = {
  description = "Some decsription",
  rules = [{
    /* A map of rules, see below */
  }]
}
```

`vpc_security_group_json` has the same structure as `vpc_security_group_map` and is used to work around data type issues in terraform when passing map environment variables from terragrunt. `vpc_security_group_map` takes precedence.

### Rules
Each rule is a map containing some of the following:

| Key | Description |Type|Required|
|-----|-------------|----|--------|
|`ipv4_cidr_blocks`|A list of IPv4 CIDRs|List|False|
|`ipv6_cidr_blocks`|A list of IPv6 CIDRs|List|False|
|`port_lower`|Lower end of the port range for this rule|Int|False|
|`port_upper`|Upper end of the port range for this rule|Int|False|
|`protocol`|Protocol number or name|String, Int|False|
|`rule_description`|A description added to this rule|String|False|
|`rule_name`|The name of this rule. Must be unique to the SG|String|True|
|`self`|Allow access from this security group|Bool|False|
|`sg_resource_name`|A reference to another security group resource in this module|String|False|
|`source_security_group_id`|A static SG ID for this rule|String|False|
|`type`|Ingress/Egress|String|True|

By default, rules are configured to open all ports and all protocols if left unspecified.
Exactly one of
```
ipv4_cidr_blocks
ipv6_cidr_blocks
source_security_group_id
sg_resource_name
self
```
must be specified, or no rules will be created.
`sg_resource_name` references the map key of a security group in `vpc_security_group_map`. Self-reference here might chicken-and-egg the infra, so use `self` instead.

### Example
```hcl
{
  "allow_out" = {
    "description" = "Allow all traffic out"
    "rules" = [
      {
        "ipv4_cidr_blocks" = [
          "0.0.0.0/0",
        ]
        "rule_name" = "allow_out"
        "type" = "egress"
      },
    ]
  }
  "private_container" = {
    "description" = "Access from ALBs to containers"
    "rules" = [
      {
        "port_lower" = 443
        "port_upper" = 443
        "protocol" = 6
        "rule_name" = "https"
        "sg_resource_name" = "public_web"
        "type" = "ingress"
      },
    ]
  }
  "public_web" = {
    "description" = "Public web access"
    "rules" = [
      {
        "ipv4_cidr_blocks" = [
          "0.0.0.0/0",
        ]
        "port_lower" = 80
        "port_upper" = 80
        "protocol" = 6
        "rule_name" = "http"
        "type" = "ingress"
      },
      {
        "ipv4_cidr_blocks" = [
          "0.0.0.0/0",
        ]
        "port_lower" = 443
        "port_upper" = 443
        "protocol" = 6
        "rule_name" = "https"
        "type" = "ingress"
      },
    ]
  }
}
```
This will create three security groups, `allow_out`, `private_container`, `public_web`. Here we can see the relationships between 2 defined groups using the `sg_resource_name` parameter.

Public HTTP/HTTPS traffic is allowed into `public_web`, and then HTTPS traffic is allowed in from  `public_web` to `private_container`. This way we don't have to know what security group IDs are beforehand.

Static SG IDs (such as those output from other modules) can also be used with the `source_security_group_id` parameter.

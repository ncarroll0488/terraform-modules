<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.28.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_policy.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_policy) | resource |
| [aws_vpc_endpoint_route_table_association.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_security_group_association.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_security_group_association) | resource |
| [aws_vpc_endpoint_subnet_association.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_subnet_association) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gateway_policies"></a> [gateway\_policies](#input\_gateway\_policies) | A map of {service => JSON} documents used as resource access policies on gateway-type subnets | `map(string)` | `{}` | no |
| <a name="input_gateway_route_tables"></a> [gateway\_route\_tables](#input\_gateway\_route\_tables) | A list of route tables to which gateway service endponts will be attached | `list(string)` | `[]` | no |
| <a name="input_gateway_services"></a> [gateway\_services](#input\_gateway\_services) | A list of AWS services to provision as gateway endpoints | `list(string)` | `[]` | no |
| <a name="input_interface_security_group_ids"></a> [interface\_security\_group\_ids](#input\_interface\_security\_group\_ids) | Security group IDs to assign to interface-based service endpoints | `list(string)` | `[]` | no |
| <a name="input_interface_services"></a> [interface\_services](#input\_interface\_services) | A list of AWS services to provision as interface endpoints | `list(string)` | `[]` | no |
| <a name="input_interface_subnets"></a> [interface\_subnets](#input\_interface\_subnets) | A list of subnet IDs into which interface service endpoint interfaces will be placed | `list(string)` | `[]` | no |
| <a name="input_service_domains"></a> [service\_domains](#input\_service\_domains) | A list of domain components used to assemble the service endpoint name. You almost certainly do not need to change this in production, but the option exists for edge cases like running against a test API. | `list(string)` | <pre>[<br/>  "com",<br/>  "amazonaws"<br/>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC in which to create the interface | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Description
This module creates VPC service endpoints for secure access to AWS services. 
!!! WARNING !!! Interface-based service endpoints can be expensive

## Usage
Simply provide a list of services, and this module will create the appropriate type of endpoint for you. Region is automatically determined as well. For services that require a gateway-type endpoint (S3, DynamoDB), this module will need a list of route tables provided. For services that require an interface endpoint, a list of security groups and subnets must be provided. A mix of interface and gateway-based services may be provided all at once.

## Examples
### Interface-only
This creates service endpoints for EC2 and ECR and associates private DNS into the VPC for access.
```hcl
module "endpoints" {
  source = "../../module/vpc_endpoint"
  vpc_id = "vpc-123"
  endpoints = ["ec2", "ecr"]
  subnets = ["subnet-1", "subnet-2"]
  interface_sg_ids = ["sg-123"]
}
```

### Gateway-only
This creates service endpoints for S3 and DynamoDB and modifies route tables to point to the endpoint
```hcl
module "endpoints" {
  source = "../../module/vpc_endpoint"
  vpc_id = "vpc-123"
  endpoints = ["s3", "dynamodb"]
  route_tables = ["rtb-1", "rtb-2"]
}
```

### Both
This will create service endpoints for all of S3, Dynamo, ECS, ECR. Route tables are adjusted for S3 and Dynamo. DNS is added for ECS and ECR
```hcl
module "endpoints" {
  source = "../../module/vpc_endpoint"
  vpc_id = "vpc-123"
  endpoints = ["s3", "dynamodb", "ec2", "ecr"]
  subnets = ["subnet-1", "subnet-2"]
  interface_sg_ids = ["sg-123"]
  route_tables = ["rtb-1", "rtb-2"]
}
```

variable "vpc_name" {
  type        = string
  default     = "Main VPC"
  description = "Name of the VPC. Used in tags"
}

variable "primary_cidr" {
  type        = string
  description = "Primary VPC CIDR"
}

variable "provision_public_subnets" {
  type        = bool
  default     = false
  description = "Enables provisioning of public subnets, which use an IGW to get to the internet"
}

variable "provision_private_subnets" {
  type        = bool
  default     = false
  description = "Enables provisioning of private subnets, which use a NGW to get to the internet. This also enables public subnets"
}

variable "provision_internal_subnets" {
  type        = bool
  default     = false
  description = "Enables provisioning of internal subnets, which do not have internet access"
}

variable "public_subnet_cidr" {
  type        = string
  default     = ""
  description = "Provision the public subnets from this CIDR."
}

variable "private_subnet_cidr" {
  type        = string
  default     = ""
  description = "Provision the private subnets from this CIDR."
}

variable "internal_subnet_cidr" {
  type        = string
  default     = ""
  description = "Provision the internal subnets from this CIDR."
}

variable "pad_cidrs" {
  type        = bool
  default     = true
  description = "Leave gaps between unused availabiity zones and subnet classes."
}

variable "ignore_availability_zone_ids" {
  type        = list(string)
  default     = []
  description = "Ignore these availability zones. Note that changing this setting may result in lots of resources being replaced"
}

variable "desired_availability_zones" {
  type        = number
  default     = 3
  description = "How many availability zones to use. The module will fail if there aren't enough AZs"
}

variable "additional_cidrs" {
  type        = list(string)
  default     = []
  description = "Additional VPC CIDRs not otherwise specified"
}

variable "nat_type" {
  type        = string
  default     = "ngw"
  description = "Pick the type of NAT used. Allowed values, `ec2`, `ngw`"
}

variable "ec2_gateway_egress_v4_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDRs the NAT gateways are allowed to access. Only used for EC2 nat."
}

variable "ec2_gateway_ingress_v4_cidrs" {
  type        = list(string)
  default     = []
  description = "List of CIDRs allowed to forward traffic over the NAT. If left empty, this will allow all VPC CIDRs. Only used in EC2 nat."
}

variable "ec2_gateway_instance_arch" {
  type        = string
  default     = "arm64"
  description = "Arch of the NAT instance, used in AMI lookup."
}

variable "ec2_gateway_instance_type" {
  type        = string
  default     = "t4g.nano"
  description = "Instance type used for the NAT"
}

variable "ec2_gateway_iam_role" {
  type        = string
  default     = ""
  description = "Specify an IAM role to associate with an iam instance profile"
}

variable "ec2_gateway_ssh_key_name" {
  type        = string
  default     = ""
  description = "SSH Keypair used by the nat instances"
}

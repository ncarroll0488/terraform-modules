variable "nat_gateways" {
  description = "A map of name => subnet"
  type        = map(string)
}

variable "allowed_cidrs" {
  description = "CIDRs allowed to send traffic through the NAT. This is used in iptables config and the security group"
  type        = list(string)
}

variable "routes" {
  description = "A map of NAT name => [route tables]"
  type        = map(list(string))
}

variable "security_groups" {
  description = "External security groups to add to the NATs"
  type        = list(string)
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "gateway_instance_type" {
  description = "Instance type used for the NAT"
  type        = string
  default     = "t4g.nano"
}

variable "gateway_instance_arch" {
  description = "Arch of the NAT instance, used in AMI lookup."
  type        = string
  default     = "arm64"
}

variable "forward_cidrs" {
  description = "CIDRs which will be forwarded over the NAT"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nat_name" {
  description = "NAT name used in tags"
  type        = string
  default     = "NAT"
}

variable "key_name" {
  description = "SSH Keypair used by the nat hosts"
  type        = string
  default     = null
}

variable "allocate_eip" {
  description = "Allocate EIPs for the NATs. You may wish to turn this off for NAT inside a private network"
  type        = bool
  default     = true
}

variable "iam_role" {
  description = "Name of an optional IAM role to associate with the NAT instances"
  type        = string
  default     = ""
}

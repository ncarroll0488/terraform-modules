variable "role_name" {
  type        = string
  description = "Name of the roles created in this module"
}

variable "task_roles" {
  type = map(object({
    policies             = optional(list(string), []),
    permissions_boundary = optional(string)
  }))
  description = "A map of role => config. Currently supported config fields: `policies`"
  validation {
    condition     = length(var.task_roles) > 0
    error_message = "Specify at least one task role."
  }
}

variable "iam_entity_path" {
  type        = string
  description = "Put IAM entities under this path"
  default     = null
}

variable "ecr_repo_arns" {
  type        = list(string)
  description = "List of ECR Repos ARNs accessible by these roles. Defaults to [*]"
  default     = []
}

variable "task_definition_arns" {
  type        = list(string)
  description = "Restrict the service role to these task definition ARNs."
  default     = []
}

variable "kms_key_arns" {
  type        = list(string)
  description = "KMS Key IDs which will be used for encrypt/decrypt"
  default     = []
}

variable "cloudwatch_log_group_arns" {
  type        = list(string)
  description = "ARNs of log groups to be included in policies"
  default     = []
}

variable "vpc_ids" {
  type        = list(string)
  description = "IDs of vpcs where tasks are allowed to run. Leaving this empty means unrestricted placement"
  default     = []
}

variable "ecs_cluster_arns" {
  type        = list(string)
  description = "List of cluster ARNs in which these roles can run tasks"
  default     = []
}

variable "secret_arns" {
  type        = list(string)
  description = "List of secret ARNs this role will be able to access"
  default     = []
}

variable "ssm_parameter_arns" {
  type        = list(string)
  description = "List of SSM parameter ARNs this role will be able to acces"
  default     = []
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of a permission boundary policy to apply to the task, service, execurtion, and eventbridge roles"
  default     = null
}

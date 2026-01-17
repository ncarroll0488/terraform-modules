variable "service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "cluster_id" {
  description = "The ECS cluster where the service will run."
  type        = string
}

variable "task_definition" {
  description = "The task definition ARN to associate with the service."
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task to run in the service."
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "The launch type on which to run the service. Possible values: EC2 or FARGATE."
  type        = string
  validation {
    condition     = contains(["EC2", "FARGATE"], upper(var.launch_type))
    error_message = "Launch type must be EC2 or FARGATE"
  }
}

variable "subnets" {
  description = "A list of subnet IDs for the ECS service to use in the VPC."
  type        = list(string)
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ECS service."
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP address to the service task (required for Fargate)."
  type        = bool
  default     = false
}

variable "health_check_grace_period_seconds" {
  description = "The amount of time to ignore failing health checks after a task has been started."
  type        = number
  default     = 60
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit on the number of running tasks during a deployment."
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "The upper limit on the number of running tasks during a deployment."
  type        = number
  default     = 200
}

variable "force_new_deployment" {
  description = "Whether to force a new deployment of the ECS service."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the ECS service."
  type        = map(string)
  default     = {}
}

/* Note: Create the load balancers and target groups elsewhere, and use their outputs here */
variable "lb_associations" {
  description = "list of maps containing `target_group_arn`, `container_name`, `container_port`"
  type        = list(map(string))
  default     = []
}

variable "availability_zone_rebalancing" {
  description = "Enable AZ rebalancing"
  type        = bool
  default     = false
}

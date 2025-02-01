variable "family" {
  description = "The name of the family for this task definition."
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that Amazon ECS can assume to pull container images."
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that grants permissions to the task."
  type        = string
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task."
  type        = string
  default     = "awsvpc"
}

variable "container_definitions" {
  description = "A valid JSON string for the container definitions."
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to reserve for the task."
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the task."
  type        = string
}

variable "requires_compatibilities" {
  description = "A list of launch types required by the task."
  type        = list(string)
}

variable "runtime_platform" {
  description = "The platform for the task to run on (Linux or Windows)."
  type        = string
  default     = "LINUX"
}

variable "tags" {
  description = "A map of tags to assign to the task definition."
  type        = map(string)
  default     = {}
}

variable "volumes" {
  description = "A list of volume mounts which contain `volume_name`, `efs_file_system_id`, and `host_path`. Optionally, `efs_root_directory` can be added to select a subdirectory of your EFS share"
  type        = list(object({}))
  default     = []
}

variable "operating_system_family" {
  type        = string
  description = "The task's operating system"
  validation {
    condition     = contains(["LINUX", "WINDOWS_SERVER_2019_FULL", "WINDOWS_SERVER_2019_CORE", "WINDOWS_SERVER_2022_FULL", "WINDOWS_SERVER_2022_CORE"], upper(var.operating_system_family))
    error_message = "Operating system invalid. See: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#runtime-platform . "
  }
}

variable "cpu_architecture" {
  type        = string
  description = "The task's CPU arch"
  validation {
    condition     = contains(["X86_64", "ARM64"], upper(var.cpu_architecture))
    error_message = "CPU architecture invalid. Must be X86_64 or ARM64."
  }
}

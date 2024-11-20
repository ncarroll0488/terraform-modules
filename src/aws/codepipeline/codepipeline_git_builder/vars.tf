variable "pipeline_name" {
  type        = string
  description = "Name of the pipeline and resources associated with it"
}

variable "artifacts_bucket_name" {
  type        = string
  default     = ""
  description = "name of a pre-created bucket to use for artifacts"
}

variable "artifacts_bucket_kms_key_id" {
  type        = string
  description = "KMS key to use to secure this bucket"
  default     = null
}

variable "artifacts_bucket_encryption_algorithm" {
  type        = string
  description = "Algorithm to use for bucket encryption"
  default     = "aws:kms"
}

variable "default_branch_name" {
  type        = string
  description = "Default branch configured in the Source stage."
  default     = "main"
}

variable "repository_id" {
  type        = string
  description = "ID of the repository, `organization/repo`"
}

variable "pull_request_builder" {
  type        = bool
  description = "Enable building on pull requests"
  default     = false
}

variable "codestar_connection_arn" {
  type        = string
  description = "ARN of an existing CodeStar connection to use"
  default     = ""
}

variable "pr_build_exclude_branches" {
  type        = list(string)
  description = "A list of branch names excluded from pull request builds"
  default     = null
}

variable "pr_build_include_branches" {
  type        = list(string)
  description = "A list of branch names included in pull request builds"
  default     = ["**"]
}

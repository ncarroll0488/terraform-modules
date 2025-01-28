output "ecr_repo_arn" {
  value       = aws_ecr_repository.main.arn
  description = "The ARN of the repo"
}

output "ecr_repo_url" {
  value       = aws_ecr_repository.main.repository_url
  description = "The URL of the repo, for docker, etc"
}

output "ecr_repo_name" {
  value       = aws_ecr_repository.main.name
  description = "Name of the repo"
}

output "kms_key_arn" {
  value       = lower(var.encryption_type) == "kms" ? local.kms_key_arn : ""
  description = "ARN of the KMS key created for this repo"
}

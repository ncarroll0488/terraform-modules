output "s3_object_bucket" {
  description = "Bucket where the package is stored"
  value       = aws_s3_object.package.bucket
}

output "s3_object_key" {
  description = "Filename of the package in S3"
  value       = aws_s3_object.package.key
}

output "s3_object_version_id" {
  description = "Version ID of the most recently built package"
  value       = aws_s3_object.package.version_id
}

output "s3_object_arn" {
  description = "ARN of the package"
  value       = aws_s3_object.package.arn
}

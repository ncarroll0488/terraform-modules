output "kms_key_arn" {
  description = "ARN of the key"
  value       = aws_kms_key.main.arn
}

output "kms_key_id" {
  description = "AWS UID of the key"
  value       = aws_kms_key.main.key_id
}

output "kms_key_aliases" {
  description = "Aliases assigned to this key"
  value       = { for k, v in aws_kms_alias.main : k => { alias_arn = v.arn, key_arn = v.target_key_arn } }
}

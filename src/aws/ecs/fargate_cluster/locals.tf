locals {
  cloudwatch_log_group_arn  = var.cloudwatch_log_group_arn == "" ? aws_cloudwatch_log_group.main["main"].arn : var.cloudwatch_log_group_arn
  cloudwatch_log_stream_arn = "${local.cloudwatch_log_group_arn}:log-stream:*"
}

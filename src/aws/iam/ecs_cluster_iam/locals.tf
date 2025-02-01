locals {
  cloudwatch_log_stream_arns = [for x in toset(var.cloudwatch_log_group_arns) : "${x}:log-stream:*"]
}

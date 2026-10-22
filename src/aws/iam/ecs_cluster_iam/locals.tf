locals {
  cloudwatch_log_stream_arns = [for x in toset(var.cloudwatch_log_group_arns) : "${x}:log-stream:*"]
  policy_attachment_map = merge([
    for k, v in var.task_roles : {
      for policy in v.policies : join("-", [k, policy]) => { role = k, policy = policy }
    }
  ]...)
}

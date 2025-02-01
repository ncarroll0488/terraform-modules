resource "aws_cloudwatch_log_group" "main" {
  for_each    = var.cloudwatch_log_group_arn == "" ? ["main"] : []
  name_prefix = "ecs_${var.cluster_name}"

  tags = {
    Name = "Log group for ECS cluster: ${var.cluster_name}"
  }
}


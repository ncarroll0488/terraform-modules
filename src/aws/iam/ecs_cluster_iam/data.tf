data "aws_arn" "clusters" {
  for_each = toset(var.ecs_cluster_arns)
  arn      = each.value
}

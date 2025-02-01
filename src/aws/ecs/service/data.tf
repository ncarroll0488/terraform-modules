data "aws_lb_target_group" "main" {
  for_each = { for target in var.target_group_associations : "${target.container_name}-${target.container_port}" => target }
  arn      = each.value.target_group_arn
}

data "aws_lb" "main" {
  for_each = data.aws_lb_target_group.main
  arn      = each.value.arn
}

data "aws_lb" "main" {
  for_each = local.lb_association_map
  arn      = each.value.lb_arn
}

data "aws_subnet" "main" {
  for_each = { for k, v in data.aws_lb.main : k => v.subnets[0] }
  id       = each.value
}

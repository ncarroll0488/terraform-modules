resource "aws_lb_target_group" "main" {
  for_each    = local.target_group_configuration
  name_prefix = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = "ip"
  vpc_id      = each.value.vpc_id
  depends_on = [
    data.aws_subnet.main
  ]
}

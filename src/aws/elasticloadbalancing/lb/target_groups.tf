resource "aws_lb_target_group" "main" {
  for_each    = local.listener_forwarding
  name_prefix = substr(each.key, 0, 6)
  port        = each.value.target_port
  protocol    = each.value.target_protocol
  target_type = "ip"
  vpc_id      = values(data.aws_subnet.main)[0].vpc_id
}

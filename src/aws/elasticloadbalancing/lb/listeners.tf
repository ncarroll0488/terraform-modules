resource "aws_lb_listener" "main" {
  for_each          = local.listener_forwarding
  load_balancer_arn = aws_lb.main.arn
  alpn_policy       = try(each.value.listener_alpn_policy, null)
  certificate_arn   = contains(["HTTPS", "TLS"], upper(each.value.listener_protocol)) ? each.value.listener_certificate_arn : null
  port              = each.value.listener_port
  protocol          = each.value.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = lookup(aws_lb_target_group.main, each.key).arn
  }
}

# If this is an ALB, attaches it as an NLB's target
resource "aws_lb_target_group_attachment" "nlb_to_alb" {
  for_each         = var.lb_type == "application" ? { for k, v in var.listener_forwarding : k => v if can(v.nlb_target_group) } : {}
  target_group_arn = each.value.nlb_target_group
  target_id        = aws_lb.main.arn
  port             = each.value.target_port
}

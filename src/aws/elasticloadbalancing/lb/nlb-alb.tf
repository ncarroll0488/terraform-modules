# If this is an ALB, attaches it as an NLB's target
resource "aws_lb_target_group_attachment" "nlb_to_alb" {
  for_each         = var.lb_type == "application" ? var.listener_nlb_attachments : {}
  target_group_arn = each.value.nlb_target_group
  target_id        = aws_lb.main.arn
  port             = aws_lb_listener.main[each.value.listener].port
}

resource "aws_lb_target_group_attachment" "nlb_to_alb_http_redir" {
  for_each         = toset(var.lb_type == "application" && var.https_redirect ? var.https_redirect_listener_nlb_target_group : [])
  depends_on       = [aws_lb_listener.redirect_https]
  target_group_arn = each.value
  target_id        = aws_lb.main.arn
  port             = var.https_redirect_from_port
}


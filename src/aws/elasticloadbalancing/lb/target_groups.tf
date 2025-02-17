resource "aws_lb_target_group" "main" {
  for_each    = local.listener_forwarding
  name_prefix = substr(each.key, 0, 6)
  port        = each.value.target_port
  protocol    = each.value.target_protocol
  target_type = "ip"
  vpc_id      = each.value.vpc_id
  health_check {
    enabled             = try(each.value.health_check_enabled, null)
    matcher             = try(each.value.health_check_matcher, null)
    path                = try(each.value.health_check_path, null)
    port                = try(each.value.health_check_port, null)
    protocol            = try(each.value.health_check_protocol, null)
    timeout             = try(each.value.health_check_timeout, null)
    unhealthy_threshold = try(each.value.health_check_unhealthy_threshold, null)
  }
  tags = merge(var.tags, { Name = "${var.lb_name}:${each.key}" })
}

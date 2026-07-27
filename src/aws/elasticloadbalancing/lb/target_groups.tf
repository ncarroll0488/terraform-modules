resource "aws_lb_target_group" "main" {
  for_each             = var.target_groups
  name_prefix          = substr(each.key, 0, 6)
  port                 = each.value.target_port
  protocol             = each.value.target_protocol
  target_type          = each.value.target_type
  vpc_id               = each.value.vpc_id
  deregistration_delay = each.value.deregistration_delay
  health_check {
    enabled             = each.value.health_check_enabled
    matcher             = each.value.health_check_matcher
    path                = each.value.health_check_path
    port                = each.value.health_check_port
    protocol            = each.value.health_check_protocol
    timeout             = each.value.health_check_timeout
    unhealthy_threshold = each.value.health_check_unhealthy_threshold
  }
  tags = merge(var.tags, { Name = "${var.lb_name}:${each.key}" })
}

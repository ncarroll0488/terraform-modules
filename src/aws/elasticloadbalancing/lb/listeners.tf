resource "aws_lb_listener" "main" {
  for_each          = var.listeners
  load_balancer_arn = aws_lb.main.arn
  alpn_policy       = try(each.value.listener_alpn_policy, null)
  certificate_arn   = contains(["HTTPS", "TLS"], upper(each.value.listener_protocol)) ? each.value.certificate_arn : null
  port              = each.value.listener_port
  protocol          = each.value.listener_protocol

  // Default to a fixed response for ALBs. Further config required to talk to targets
  dynamic "default_action" {
    for_each = each.value.default_action_target == null && var.lb_type == "application" ? ["a"] : []
    content {
      type = "fixed-response"
      fixed_response {
        content_type = try(each.value.default_response_content_type, "text/plain")
        message_body = try(each.value.default_response_content, "Hello, world!")
        status_code  = try(each.value.default_response_status, "200")
      }
    }
  }

  dynamic "default_action" {
    for_each = each.value.default_action_target == null ? [] : ["a"]

    content {
      type             = "forward"
      target_group_arn = lookup(aws_lb_target_group.main, each.value.default_action_target).arn
    }

  }
  tags = merge(var.tags, { name = "${var.lb_name}:${each.key}" })
}

resource "aws_lb_listener_rule" "forward" {
  for_each     = var.lb_type == "application" ? var.forwarding_rules : {}
  listener_arn = aws_lb_listener.main[each.value.listener].arn
  priority     = each.value.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[each.value.target_group].arn
  }

  dynamic "condition" {
    for_each = length(each.value.paths) == 0 && length(each.value.hosts) == 0 ? ["a"] : []
    content {
      path_pattern {
        values = ["/*"]
      }
    }
  }

  dynamic "condition" {
    for_each = length(each.value.paths) > 0 ? ["a"] : []
    content {
      path_pattern {
        values = toset(each.value.paths)
      }
    }
  }

  dynamic "condition" {
    for_each = length(each.value.hosts) > 0 ? ["a"] : []
    content {
      host_header {
        values = each.value.hosts
      }
    }
  }
}

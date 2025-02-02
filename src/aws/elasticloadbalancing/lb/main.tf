resource "aws_lb" "main" {
  name_prefix                = substr(var.lb_name, 0, 6)
  internal                   = var.internal
  ip_address_type            = var.ip_address_type
  load_balancer_type         = lower(var.lb_type)
  subnets                    = var.subnet_ids
  enable_zonal_shift         = var.enable_zonal_shift
  enable_deletion_protection = var.enable_deletion_protection
  customer_owned_ipv4_pool   = var.customer_owned_ipv4_pool
  client_keep_alive          = var.client_keep_alive

  /* Network and application only */
  security_groups = contains(["network", "application"], lower(var.lb_type)) ? var.security_groups : null

  /* Network and gateway only */
  enable_cross_zone_load_balancing = contains(["network", "gateway"], lower(var.lb_type)) ? var.enable_cross_zone_load_balancing : true

  /* Application only */
  preserve_host_header       = lower(var.lb_type) == "application" ? var.preserve_host_header : null
  xff_header_processing_mode = lower(var.lb_type) == "application" ? var.xff_header_processing_mode : null
  enable_http2               = lower(var.lb_type) == "application" ? var.enable_http2 : null
  drop_invalid_header_fields = lower(var.lb_type) == "application" ? var.drop_invalid_header_fields : null
  desync_mitigation_mode     = lower(var.lb_type) == "application" ? var.desync_mitigation_mode : null
  dynamic "connection_logs" {
    for_each = lower(var.lb_type) == "application" && var.connection_logs_bucket != "" ? ["a"] : []
    content {
      bucket  = var.connection_logs_bucket
      enabled = var.enable_connection_logs
      prefix  = var.connection_logs_prefix
    }
  }

  /* Network only */
  dns_record_client_routing_policy = lower(var.lb_type) == "network" ? var.dns_record_client_routing_policy : null

  /* access logging */
  dynamic "access_logs" {
    for_each = var.access_logs_bucket != "" ? ["a"] : []
    content {
      bucket  = var.access_logs_bucket
      enabled = var.enable_access_logs
      prefix  = var.access_logs_prefix
    }
  }

  /* for BYO EIPs */
  dynamic "subnet_mapping" {
    for_each = var.eip_mappings
    content {
      subnet_id     = each.key
      allocation_id = each.value
    }
  }

  tags = merge(var.tags, { name = var.lb_name })
}

// This is a very common use-case, so it's added here for convenience
resource "aws_lb_listener" "redirect_https" {
  for_each          = toset(var.https_redirect && lower(var.lb_type) == "application" ? ["main"] : [])
  load_balancer_arn = aws_lb.main.arn
  port              = var.https_redirect_from_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = var.https_redirect_to_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

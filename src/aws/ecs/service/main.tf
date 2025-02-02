resource "aws_ecs_service" "main" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }
  dynamic "load_balancer" {
    for_each = tolist(var.lb_associations)
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = tonumber(load_balancer.value.container_port)
    }
  }
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  force_new_deployment               = var.force_new_deployment
  tags                               = merge(var.tags, { Name = "var.service_name" })
  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}

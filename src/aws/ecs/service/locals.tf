locals {
  lb_association_map = { for lb in var.lb_associations : "${lb.container_name}-${lb.container_port}" => lb }
  target_group_configuration = {
    for k, v in local.lb_association_map : k => {
      name     = k
      port     = v.container_port
      protocol = v.container_protocol
      vpc_id   = lookup(data.aws_subnet.main, k).vpc_id
    }
  }
  container_associations = {
    for k, v in local.lb_association_map : k => {
      container_port   = v.container_port
      container_name   = v.container_name
      target_group_arn = lookup(aws_lb_target_group.main, k).arn
    }
  }
}

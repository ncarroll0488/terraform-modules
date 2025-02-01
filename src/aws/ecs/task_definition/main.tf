resource "aws_ecs_task_definition" "main" {
  family                   = var.family
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.network_mode
  container_definitions    = var.container_definitions
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = var.requires_compatibilities
  tags                     = merge(var.tags, { Name = var.family })

  dynamic "runtime_platform" {
    for_each = contains(var.requires_compatibilities, "FARGATE") ? ["a"] : []
    content {
      operating_system_family = var.operating_system_family
      cpu_architecture        = var.cpu_architecture
    }
  }

  dynamic "volume" {
    for_each = var.volumes
    content {
      name      = each.value.volume_name
      host_path = each.value.host_path
      efs_volume_configuration {
        file_system_id = each_value.efs_file_system_id
        root_directory = try(each.value.efs_root_directory, null)
      }
    }
  }
}

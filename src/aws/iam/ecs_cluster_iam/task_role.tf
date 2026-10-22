/* This configures a task role which can be assumed by ecs-tasks. */

data "aws_iam_policy_document" "task_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task" {
  for_each             = var.task_roles
  name_prefix          = "${each.key}_task"
  path                 = var.iam_entity_path
  assume_role_policy   = data.aws_iam_policy_document.task_trust.json
  permissions_boundary = try(coalesce(each.value.permissions_boundary, var.permissions_boundary), null)

  tags = {
    Name = "${each.key} ECS Task Role"
  }
}

resource "aws_iam_role_policy_attachment" "task" {
  for_each   = local.policy_attachment_map
  role       = aws_iam_role.task[each.value.role].name
  policy_arn = each.value.policy
}

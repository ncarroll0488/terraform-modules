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
  name_prefix        = "${var.role_name}_task"
  path               = var.iam_entity_path
  assume_role_policy = data.aws_iam_policy_document.task_trust.json

  tags = {
    Name = "${var.role_name} ECS Task Role"
  }
}

resource "aws_iam_role_policy_attachment" "task" {
  for_each   = toset(var.task_role_policies)
  role       = aws_iam_role.task.name
  policy_arn = each.value
}

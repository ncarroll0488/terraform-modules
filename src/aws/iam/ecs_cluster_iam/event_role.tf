data "aws_iam_policy_document" "events_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [
        "events.amazonaws.com",
        "scheduler.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "events" {
  count                = var.enable_eventbridge_role ? 1 : 0
  name_prefix          = "${var.role_name}_events"
  path                 = var.iam_entity_path
  assume_role_policy   = data.aws_iam_policy_document.events_trust.json
  permissions_boundary = var.permissions_boundary

  tags = {
    Name = "${var.role_name} eventbridge role"
  }
}

data "aws_iam_policy_document" "events_policy" {
  statement {
    sid = "RunTask"
    actions = [
      "ecs:RunTask"
    ]
    effect    = "Allow"
    resources = coalescelist(var.task_definition_arns, ["*"])

    // Restrict these actions to our clusters
    dynamic "condition" {
      for_each = length(var.ecs_cluster_arns) > 0 ? ["a"] : []
      content {
        test     = "ArnEquals"
        variable = "ecs:cluster"
        values   = toset(var.ecs_cluster_arns)
      }
    }

    // VPC restriction
    dynamic "condition" {
      for_each = length(var.vpc_ids) > 0 ? ["a"] : []
      content {
        test     = "StringEquals"
        variable = "aws:SourceVpc"
        values   = toset(var.vpc_ids)
      }
    }
  }

  // Allow the passing of our task and execution roles
  statement {
    sid = "PassRoles"
    actions = [
      "iam:PassRole"
    ]
    effect = "Allow"
    resources = concat(
      [aws_iam_role.execution.arn],
      [for x, y in aws_iam_role.task : y.arn]
    )
  }
}

resource "aws_iam_policy" "events_policy" {
  count       = var.enable_eventbridge_role ? 1 : 0
  name_prefix = "${var.role_name}_events"
  path        = var.iam_entity_path
  description = "${var.role_name} ECS eventbridge policy"
  policy      = data.aws_iam_policy_document.events_policy.json
}

resource "aws_iam_role_policy_attachment" "events_policy" {
  count      = var.enable_eventbridge_role ? 1 : 0
  role       = aws_iam_role.events[0].name
  policy_arn = aws_iam_policy.events_policy[0].arn
}

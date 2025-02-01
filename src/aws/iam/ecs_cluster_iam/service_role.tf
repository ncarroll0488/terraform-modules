/* This configures a service role which can be assumed by EventBridge or ECS. */

data "aws_iam_policy_document" "service_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "service" {
  name_prefix        = "${var.role_name}_service"
  path               = var.iam_entity_path
  assume_role_policy = data.aws_iam_policy_document.service_trust.json

  tags = {
    Name = "${var.role_name} Service role"
  }
}

data "aws_iam_policy_document" "service_policy" {
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
    resources = [
      aws_iam_role.execution.arn,
      aws_iam_role.task.arn
    ]
  }
}

resource "aws_iam_policy" "service_policy" {
  name_prefix = "${var.role_name}_service"
  path        = var.iam_entity_path
  description = "${var.role_name} ECS service policy"
  policy      = data.aws_iam_policy_document.service_policy.json
}

resource "aws_iam_role_policy_attachment" "service_policy" {
  role       = aws_iam_role.service.name
  policy_arn = aws_iam_policy.service_policy.arn
}

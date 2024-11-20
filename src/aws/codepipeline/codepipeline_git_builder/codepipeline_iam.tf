# Use the built-in datasource to validate and format a JSON document
data "aws_iam_policy_document" "codepipeline_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create a role that codebuild will assume when running our pipeline
resource "aws_iam_role" "codepipeline_role" {
  name_prefix        = "${var.pipeline_name}_codepipeline_policy"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role_policy.json
}

# Use the built-in datasource to validate and format a JSON document
data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      data.aws_s3_bucket.artifacts.arn,
      "${data.aws_s3_bucket.artifacts.arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:*"]
    resources = [local.codestar_connection_arn]
  }

  /*
  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["#TODO add codebuild projects"]
  }
*/
}

# Create a managed policy
resource "aws_iam_policy" "codepipeline_policy" {
  name_prefix = "${var.pipeline_name}_codepipeline_policy"
  policy      = data.aws_iam_policy_document.codepipeline_policy.json
}

# Attempt to reconcile externally attached policies, which should not be present.
resource "aws_iam_role_policy_attachments_exclusive" "codepipeline" {
  role_name   = aws_iam_role.codepipeline_role.name
  policy_arns = [aws_iam_policy.codepipeline_policy.arn]
}

resource "aws_codepipeline" "codepipeline" {
  name          = var.pipeline_name
  role_arn      = aws_iam_role.codepipeline_role.arn
  pipeline_type = "V2"

  artifact_store {
    location = local.artifacts_bucket_name
    type     = "S3"

    dynamic "encryption_key" {
      for_each = var.artifacts_bucket_encryption_algorithm == "aws:kms" && var.artifacts_bucket_kms_key_id != null ? ["a"] : []
      content {
        id   = local.artifacts_bucket_kms_key_id
        type = var.artifacts_bucket_encryption_algorithm
      }
    }
  }

  # A trigger for pull requests
  dynamic "trigger" {
    for_each = var.pull_request_builder ? ["a"] : []
    content {
      provider_type = "CodeStarSourceConnection"
      git_configuration {
        source_action_name = "SourceAction"
        pull_request {
          events = ["OPEN", "UPDATED"]
          branches {
            excludes = var.pr_build_exclude_branches
            includes = var.pr_build_include_branches
          }
          file_paths {
            includes = ["**"]
            excludes = [
              "**/README.md",
              "**/LICENSE",
              "**/CONTRIBUTING.md"
            ]
          }
        }
      }
    }
  }
  stage {
    name = "SourceStage"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      namespace        = "foo"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = local.codestar_connection_arn
        FullRepositoryId = var.repository_id

        /* Documentation suggests that this is merely a default, and a trigger would pull the correct commit */
        BranchName = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "test"
      }
    }
  }
  /*
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }
  */
}

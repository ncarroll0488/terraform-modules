resource "random_password" "password" {
  length  = 16
  special = true
}

resource "aws_codepipeline_webhook" "main" {
  name            = "test-webhook-github-bar"
  authentication  = "GITHUB_HMAC"
  target_action   = "SourceAction"
  target_pipeline = aws_codepipeline.codepipeline.name

  authentication_configuration {
    secret_token = random_password.password.result
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/.*"
  }
  lifecycle {
    ignore_changes = [
      authentication_configuration[0].secret_token
    ]
  }
}

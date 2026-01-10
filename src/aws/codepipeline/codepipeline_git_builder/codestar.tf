resource "aws_codestarconnections_connection" "main" {
  for_each      = toset(local.create_codestar_connection ? ["main"] : [])
  name          = "${var.pipeline_name}_codestar_conn"
  provider_type = "GitHub"
}

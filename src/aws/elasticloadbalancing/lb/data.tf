data "aws_subnet" "main" {
  for_each = toset(var.subnet_ids)
  id       = each.value
}

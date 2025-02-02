resource "aws_rds_cluster" "main" {
  cluster_identifier            = var.cluster_name
  engine                        = "aurora-mysql"
  engine_mode                   = "provisioned"
  engine_version                = var.engine_version
  database_name                 = var.db_name
  master_username               = var.master_username
  manage_master_user_password   = true
  master_user_secret_kms_key_id = var.master_password_kms_key
  kms_key_id                    = var.kms_key_id
  storage_encrypted             = true
  db_subnet_group_name          = aws_db_subnet_group.main.name
  vpc_security_group_ids        = toset(var.security_group_ids)

  serverlessv2_scaling_configuration {
    max_capacity             = var.max_db_capacity
    min_capacity             = var.min_db_capacity
    seconds_until_auto_pause = var.db_pause_timer
  }
  tags = merge(var.tags, { "Name" = var.cluster_name })
}

resource "aws_rds_cluster_instance" "main" {
  for_each           = toset([for x in range(0, var.instance_count) : "db-${x}"])
  identifier         = "${var.cluster_name}-${each.value}"
  cluster_identifier = aws_rds_cluster.main.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.main.engine
  engine_version     = aws_rds_cluster.main.engine_version
  tags               = merge(var.tags, { "Name" = "${var.cluster_name}-${each.value}" })
}

resource "aws_db_subnet_group" "main" {
  name_prefix = "var.cluster_name"
  description = var.cluster_name
  subnet_ids  = var.subnet_ids
  tags        = merge(var.tags, { "Name" = var.cluster_name })
}

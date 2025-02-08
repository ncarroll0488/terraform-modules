resource "aws_db_instance" "main" {
  identifier_prefix             = var.instance_identifier
  engine                        = "mariadb"
  engine_version                = var.engine_version
  db_name                       = var.db_name
  username                      = var.master_username
  manage_master_user_password   = true
  master_user_secret_kms_key_id = var.master_password_kms_key
  kms_key_id                    = var.kms_key_id
  storage_encrypted             = true
  db_subnet_group_name          = aws_db_subnet_group.main.name
  vpc_security_group_ids        = toset(var.security_group_ids)
  tags                          = merge(var.tags, { "Name" = var.instance_identifier })
  skip_final_snapshot           = var.skip_final_snapshot
  final_snapshot_identifier     = var.skip_final_snapshot ? null : coalesce(var.final_snapshot_identifier, "${var.instance_identifier}-final")
  instance_class                = var.instance_class

  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = max(var.max_allocated_storage, var.allocated_storage)

  lifecycle {
    ignore_changes = [
      identifier,
      identifier_prefix
    ]
  }
}

resource "aws_db_instance" "replica" {
  count               = var.replicas
  identifier_prefix   = "${var.instance_identifier}-replica"
  replicate_source_db = aws_db_instance.main.identifier
  kms_key_id          = var.kms_key_id
  storage_encrypted   = true
  instance_class      = coalesce(var.replica_instance_class, var.instance_class)
  tags                = merge(var.tags, { "Name" = "${var.instance_identifier}-replica-${count.index}" })

  lifecycle {
    ignore_changes = [
      identifier,
      identifier_prefix
    ]
  }
}

resource "aws_db_subnet_group" "main" {
  name_prefix = var.instance_identifier
  description = var.instance_identifier
  subnet_ids  = var.subnet_ids
  tags        = merge(var.tags, { "Name" = var.instance_identifier })
}

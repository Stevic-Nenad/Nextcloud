resource "aws_db_subnet_group" "nextcloud_rds" {
  name       = "${lower(var.project_name)}-rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-rds-subnet-group"
    }
  )
}

resource "aws_db_parameter_group" "nextcloud_postgres" {
  name   = "${lower(var.project_name)}-postgres-${replace(var.rds_pg_version, ".", "")}"
  family = "postgres${split(".", var.rds_pg_version)[0]}" # <--- FIX APPLIED HERE

  parameter {
    name  = "client_encoding"
    value = "UTF8"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-pg-params"
    }
  )
}

data "aws_secretsmanager_secret" "rds_master_password_secret" {
  name = "nextcloud/rds/master-password"
}

data "aws_secretsmanager_secret_version" "rds_master_password_version" {
  secret_id = data.aws_secretsmanager_secret.rds_master_password_secret.id
}

resource "aws_db_instance" "nextcloud" {
  identifier            = "${lower(var.project_name)}-db-instance"
  engine                = "postgres"
  engine_version        = var.rds_pg_version
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  storage_type          = "gp3"
  max_allocated_storage = 100 # Allows for auto-scaling storage

  username = var.rds_master_username
  password = data.aws_secretsmanager_secret_version.rds_master_password_version.secret_string
  db_name  = var.rds_db_name

  db_subnet_group_name   = aws_db_subnet_group.nextcloud_rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  multi_az                 = var.rds_multi_az_enabled
  backup_retention_period  = 7
  delete_automated_backups = true # For easy cleanup in a dev environment
  skip_final_snapshot      = true # For easy cleanup in a dev environment

  parameter_group_name = aws_db_parameter_group.nextcloud_postgres.name

  deletion_protection = false

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-rds-instance"
    }
  )

  depends_on = [
    aws_db_subnet_group.nextcloud_rds,
  ]
}
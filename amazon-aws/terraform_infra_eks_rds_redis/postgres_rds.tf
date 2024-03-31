# # Create RDS Instance

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "postgres_rds_subnet_group"
  subnet_ids = aws_subnet.private_subnets.*.id

  tags = var.aws_tags
}

resource "aws_db_instance" "rds" {
  identifier             = var.aws_rds_identifier_name
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.id
  allocated_storage      = var.aws_rds_storage
  engine                 = var.aws_rds_engine_type
  engine_version         = var.aws_rds_engine_version
  instance_class         = var.aws_rds_instance_type
  multi_az               = var.aws_rds_multi_az
  db_name                = var.aws_rds_default_database_name
  username               = var.aws_rds_master_user_name
  password               = var.aws_rds_master_user_password
  skip_final_snapshot    = var.aws_rds_skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  tags                   = var.aws_tags
}

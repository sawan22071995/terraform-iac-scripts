resource "aws_cloudwatch_log_group" "slow_log" {
  name              = "/elasticache/${var.aws_elasticache_redis_replication_group_id_name}/slow-log"
  retention_in_days = 365
}
resource "aws_cloudwatch_log_group" "engine_log" {
  name              = "/elasticache/${var.aws_elasticache_redis_replication_group_id_name}/engine-log"
  retention_in_days = 365
}

resource "aws_elasticache_subnet_group" "elasticache_subnet" {
  name       = "elasticache-redis-subnet-group"
  subnet_ids = aws_subnet.private_subnets.*.id
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
resource "aws_elasticache_replication_group" "redis" {
  automatic_failover_enabled = var.aws_elasticache_redis_automatic_failover
  subnet_group_name          = aws_elasticache_subnet_group.elasticache_subnet.name
  replication_group_id       = var.aws_elasticache_redis_replication_group_id_name
  description                = "ElastiCache cluster for redis"
  node_type                  = var.aws_elasticache_redis_node_type
  parameter_group_name       = var.aws_elasticache_parameter_group_name
  port                       = var.aws_elasticache_redis_port
  multi_az_enabled           = var.aws_elasticache_redis_multi_az
  num_node_groups            = var.aws_elasticache_redis_node_group_count
  replicas_per_node_group    = var.aws_elasticache_redis_node_group_replica_count
  at_rest_encryption_enabled = var.aws_elasticache_redis_at_rest_encryption
  transit_encryption_enabled = var.aws_elasticache_redis_at_transit_encryption
  auth_token                 = var.aws_elasticache_redis_password
  apply_immediately          = true
  security_group_ids         = [aws_security_group.redis-sg.id]
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.slow_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.engine_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  tags = var.aws_tags
}
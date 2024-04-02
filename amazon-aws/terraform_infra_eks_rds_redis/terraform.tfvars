aws_region                                      = "ap-south-1"
aws_vpc_cidr                                    = "10.0.0.0/16"
aws_ec2_security_group_name                     = "ec2-sg"
aws_ec2_ami_type                                = "ami-0ba259e664698cbfc" # Amazon Linux 2
aws_ec2_instance_type                           = "t2.micro"
aws_ec2_public_ip_allocate                      = true
aws_ec2_ssh_key_name                            = "my-ec2-key"
aws_eks_security_group_name                     = "eks-security-group"
aws_eks_cluster_name                            = "dev-eks-01"
aws_eks_cluster_version                         = "1.29"
aws_eks_cluster_endpoint_public_access          = false
aws_eks_cluster_endpoint_private_access         = true
aws_eks_node_group_name                         = "dev-private-node-group-01"
aws_eks_node_group_instance_type                = "t3.medium"
aws_eks_node_group_scaling_config_desired_size  = 1
aws_eks_node_group_scaling_config_max_size      = 2
aws_eks_node_group_scaling_config_min_size      = 1
aws_eks_node_group_instance_capacity_type       = "ON_DEMAND"
aws_eks_node_group_update_config                = 1
aws_rds_security_group_name                     = "rds-postgres-sg"
aws_rds_identifier_name                         = "postgres-rds-01"
aws_rds_storage                                 = 10
aws_rds_engine_type                             = "postgres"
aws_rds_engine_version                          = "15"
aws_rds_instance_type                           = "db.t3.micro"
aws_rds_multi_az                                = false
aws_rds_skip_final_snapshot                     = true
aws_rds_default_database_name                   = "defaultdb"
aws_rds_master_user_name                        = "admin123"
aws_rds_master_user_password                    = "******************"
aws_rds_port                                    = 5432
aws_elasticache_redis_security_group_name       = "elasticache-redis-sg"
aws_elasticache_redis_port                      = 6379
aws_elasticache_redis_automatic_failover        = true
aws_elasticache_redis_multi_az                  = false
aws_elasticache_redis_at_rest_encryption        = false
aws_elasticache_redis_at_transit_encryption     = true
aws_elasticache_redis_replication_group_id_name = "redis-cluster-01"
aws_elasticache_redis_node_type                 = "cache.t2.small"
aws_elasticache_parameter_group_name            = "default.redis7.cluster.on"
aws_elasticache_redis_node_group_count          = 1
aws_elasticache_redis_node_group_replica_count  = 3
aws_elasticache_redis_password                  = "******************"
aws_ecr_name                                    = "dev-ecr-01"
aws_tags = {
  Environment = "Development"
  Project     = "MyProject"
  Contact     = "sawanchoksey.chouksey@gmail.com"
}

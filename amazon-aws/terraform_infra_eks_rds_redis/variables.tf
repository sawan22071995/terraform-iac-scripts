variable "aws_region" {
  description = "AWS region to create resources in"
  default     = ""
}

variable "aws_tags" {
  description = "tags allocate to all resources"
  type        = map(string)
  default     = {}
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR range"
  default     = ""
}

variable "aws_ec2_security_group_name" {
  description = "AWS security group name for ec2 jump box"
  default     = ""
}

variable "aws_ec2_ami_type" {
  description = "AWS ec2 ami type"
  default     = ""
}

variable "aws_ec2_instance_type" {
  description = "AWS ec2 instance size"
  default     = ""
}

variable "aws_ec2_public_ip_allocate" {
  description = "AWS ec2 instance allocate public IP"
  type        = bool
  default     = true
}

variable "aws_ec2_ssh_key_name" {
  description = "AWS ec2 ssh key pair name"
  default     = "my_ec2_key"
}

variable "aws_eks_security_group_name" {
  description = "AWS security group name for eks"
  default     = ""
}

variable "aws_rds_security_group_name" {
  description = "AWS security group name for postgreSQL rds"
  default     = ""
}

variable "aws_rds_identifier_name" {
  description = "AWS rds name"
  default     = ""
}

variable "aws_rds_storage" {
  description = "AWS rds storage allocated"
  type        = number
  default     = 10
}

variable "aws_rds_engine_type" {
  description = "AWS rds engine type"
  default     = "postgres"
}

variable "aws_rds_engine_version" {
  description = "AWS rds engine version"
  default     = "15"
}

variable "aws_rds_instance_type" {
  description = "AWS rds instance size"
  default     = ""
}

variable "aws_rds_multi_az" {
  description = "AWS rds mutiple availablity zone enabled"
  type        = bool
  default     = true
}

variable "aws_rds_skip_final_snapshot" {
  description = "AWS rds take final snapshot enabled"
  type        = bool
  default     = false
}

variable "aws_rds_default_database_name" {
  description = "AWS rds deafult database name"
  default     = ""
}

variable "aws_rds_master_user_name" {
  description = "AWS rds master user name"
  sensitive   = true
  default     = ""
}

variable "aws_rds_port" {
  description = "AWS rds engine port"
  type        = number
  default     = 5432
}
variable "aws_rds_master_user_password" {
  description = "AWS rds master user password"
  sensitive   = true
  default     = null
}

variable "aws_elasticache_redis_security_group_name" {
  description = "AWS security group name for elasticache redis"
  default     = ""
}

variable "aws_elasticache_redis_automatic_failover" {
  description = "AWS redis cache automatic failover enabled"
  type        = bool
  default     = true
}

variable "aws_elasticache_redis_multi_az" {
  description = "AWS redis cache mutiple availablity zone enabled"
  type        = bool
  default     = true
}

variable "aws_elasticache_redis_at_rest_encryption" {
  description = "AWS redis cache at rest encryption enabled"
  type        = bool
  default     = true
}

variable "aws_elasticache_redis_at_transit_encryption" {
  description = "AWS redis cache at transit encryption enabled"
  type        = bool
  default     = true
}

variable "aws_elasticache_redis_replication_group_id_name" {
  description = "AWS redis cache replication group id name"
  default     = ""
}

variable "aws_elasticache_redis_node_type" {
  description = "AWS redis cache node size"
  default     = ""
}

variable "aws_elasticache_parameter_group_name" {
  description = "AWS redis cache parameter group name"
  default     = ""
}

variable "aws_elasticache_redis_port" {
  description = "AWS redis port"
  type        = number
  default     = 6379
}

variable "aws_elasticache_redis_node_group_count" {
  description = "AWS redis number of node group"
  type        = number
  default     = 1
}

variable "aws_elasticache_redis_node_group_replica_count" {
  description = "AWS redis number of replicas in each node group"
  type        = number
  default     = 3
}

variable "aws_elasticache_redis_password" {
  description = "AWS redis password"
  sensitive   = true
  default     = null
}

variable "aws_eks_cluster_name" {
  description = "AWS eks cluster name"
  default     = ""
}

variable "aws_eks_cluster_version" {
  description = "AWS eks cluster version"
  default     = "1.29"
}

variable "aws_eks_cluster_endpoint_public_access" {
  description = "AWS eks cluster endpoint expose to public"
  type        = bool
  default     = false
}

variable "aws_eks_cluster_endpoint_private_access" {
  description = "AWS eks cluster endpoint expose to public"
  type        = bool
  default     = true
}

variable "aws_eks_node_group_name" {
  description = "AWS eks node group name"
  default     = ""
}

variable "aws_eks_node_group_instance_type" {
  description = "AWS eks node group name instance size"
  default     = ""
}

variable "aws_eks_node_group_scaling_config_desired_size" {
  description = "AWS eks node group scaling config desired size"
  type        = number
  default     = 1
}

variable "aws_eks_node_group_scaling_config_max_size" {
  description = "AWS eks node group scaling config max size"
  type        = number
  default     = 2
}

variable "aws_eks_node_group_scaling_config_min_size" {
  description = "AWS eks node group scaling config min size"
  type        = number
  default     = 1
}

variable "aws_eks_node_group_instance_capacity_type" {
  description = "AWS eks node group instance capacity type"
  type        = string
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.aws_eks_node_group_instance_capacity_type)
    error_message = "The environment value must be one of 'ON_DEMAND', 'SPOT'"
  }
  default = "ON_DEMAND"
}

variable "aws_eks_node_group_update_config" {
  description = "AWS eks node group update configuration"
  default     = 1
  type        = number
}

variable "aws_ecr_name" {
  description = "AWS ecr name"
  default     = ""
}



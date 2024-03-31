# Terraform setting block
output "aws_vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "aws_vpc_id" {
  value = aws_vpc.main.id
}

output "aws_private_subnet_id" {
  value = aws_subnet.private_subnets.*.id
}

output "aws_public_subnet_id" {
  value = aws_subnet.public_subnets.*.id
}

output "aws_public_subnet_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "aws_private_subnet_route_table_id" {
  value = aws_route_table.private_rt.id
}

output "aws_nat_gateway_id" {
  value = aws_nat_gateway.main.id
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "aws_ec2_jumpbox_id" {
  value = aws_instance.ec2.id
}

output "aws_ec2_ssh_key_name" {
  value = var.aws_ec2_ssh_key_name
}

output "aws_rds_database_id" {
  value = aws_db_instance.rds.id
}

output "aws_elasticache_redis_id" {
  value = aws_elasticache_replication_group.redis.id
}

output "aws_eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster_demo.id
}

output "aws_eks_worker_node_group_id" {
  value = aws_eks_node_group.private_node_group.id
}

output "aws_ec2_security_group_name" {
  value = var.aws_ec2_security_group_name
}

output "aws_eks_security_group_name" {
  value = var.aws_eks_security_group_name
}

output "aws_rds_postgres_database_security_group_name" {
  value = var.aws_rds_security_group_name
}

output "aws_elasticache_redis_security_group_name" {
  value = var.aws_elasticache_redis_security_group_name
}



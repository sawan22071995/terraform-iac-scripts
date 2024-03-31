# Create the private EKS node group
resource "aws_eks_node_group" "private_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster_demo.name
  node_group_name = var.aws_eks_node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.private_subnets[*].id
  instance_types  = [var.aws_eks_node_group_instance_type]

  scaling_config {
    desired_size = var.aws_eks_node_group_scaling_config_desired_size
    max_size     = var.aws_eks_node_group_scaling_config_max_size
    min_size     = var.aws_eks_node_group_scaling_config_min_size
  }

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = var.aws_eks_node_group_instance_capacity_type

  update_config {
    max_unavailable = var.aws_eks_node_group_update_config
  }

  # Lifecycle
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy,
    aws_iam_role_policy_attachment.eks_CNI_policy,
    aws_iam_role_policy_attachment.eks_ec2_policy,
  ]

  remote_access {
    ec2_ssh_key = var.aws_ec2_ssh_key_name # Replace with your key pair name
    source_security_group_ids = [
      aws_security_group.ec2.id
    ]
  }

  tags = var.aws_tags
}


  
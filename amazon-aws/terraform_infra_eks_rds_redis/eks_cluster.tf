resource "aws_eks_cluster" "eks_cluster_demo" {
  name     = var.aws_eks_cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.aws_eks_cluster_version

  vpc_config {
    subnet_ids              = aws_subnet.private_subnets[*].id
    endpoint_private_access = var.aws_eks_cluster_endpoint_private_access
    endpoint_public_access  = var.aws_eks_cluster_endpoint_public_access
    security_group_ids      = [aws_security_group.eks_security_group.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_cluster_vpc_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
  ]
  tags = var.aws_tags
}

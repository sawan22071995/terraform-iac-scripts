module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_name
  subnet_ids      = aws_subnet.private_subnets[count.index]
  vpc_id          = aws_vpc.main.id
  cluster_version = var.eks_version
}

module "eks_node_groups" {
  for_each        = var.eks_node_groups
  source          = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  cluster_name    = module.eks.cluster_id
  name            = each.key
  subnet_ids      = aws_subnet.private_subnets[count.index]
  desired_size    = each.value.desired_size
  max_size        = each.value.max_size
  min_size        = each.value.min_size
  instance_types  = each.value.instance_type
  # Other parameters...
  # See module documentation for all available options
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/managed_node_groups.md
}
resource "aws_eks_node_group" "main_nodes" {
  cluster_name  = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-main-nodes"
  node_role_arn = aws_iam_role.eks_node_role.arn

  subnet_ids    = aws_subnet.private[*].id

  instance_types = var.eks_node_instance_types
  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 2 //Enough for basic HA
    max_size     = 2
    min_size     = 2
  }

  update_config {
    max_unavailable_percentage = 50
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-main-node-group"
    }
  )

  # Ensure the cluster and node IAM role policies are created before the node group
  depends_on = [
    aws_eks_cluster.main,
    aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy,
  ]
}
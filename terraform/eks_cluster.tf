resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
    endpoint_private_access = false
    endpoint_public_access = true
    public_access_cidrs = var.eks_public_access_cidrs
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-eks-cluster"
    }
  )

  # Ensure IAM role and policies are created before the cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
  ]
}
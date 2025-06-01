# --- IAM Role for EKS Cluster ---
# This IAM role is assumed by the EKS control plane.
# It grants the EKS service permissions to make AWS API calls on your behalf to manage resources
# required for the cluster's operation. For example, creating and managing Elastic Network Interfaces (ENIs)
# in your VPC subnets for control plane communication, or managing Load Balancers for Kubernetes services.
#
# Assume Role Policy (Trust Policy):
# This JSON policy defines which principals (entities) are allowed to assume this role.
# For the EKS Cluster Role, the principal is the EKS service itself ('eks.amazonaws.com').
# AWS Documentation on Trust Policies: https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-trust-policies.html
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-eks-cluster-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# --- IAM Role for EKS Node Group ---
# This IAM role is assumed by the EC2 instances that act as worker nodes in your EKS cluster.
# It grants these instances permissions to:
#   1. Communicate with the EKS control plane (e.g., register themselves, receive workloads).
#   2. Pull container images from Amazon ECR.
#   3. Manage networking resources via the AWS VPC CNI plugin.
#   4. Other operations necessary for a Kubernetes node to function (e.g., write logs to CloudWatch).
#
# Assume Role Policy (Trust Policy):
# For the EKS Node Role, the principal is the EC2 service ('ec2.amazonaws.com'), allowing EC2 instances
# to assume this role when they are launched as part of the EKS node group.
resource "aws_iam_role" "eks_node_role" {
  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-eks-node-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}
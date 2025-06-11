output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets."
  value       = aws_subnet.private[*].id
}

output "availability_zones_used" {
  description = "List of Availability Zones where subnets were created."
  value       = var.availability_zones
}

output "nat_gateway_public_ips" {
  description = "List of Public IP addresses of the NAT Gateways (one per AZ)."
  value       = aws_eip.nat_eip_per_az[*].public_ip
}

output "nat_gateway_ids" {
  description = "List of IDs of the NAT Gateways (one per AZ)."
  value       = aws_nat_gateway.nat_gw_per_az[*].id
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for your EKS Kubernetes API server."
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true // Mark as sensitive as it's credential-like
}

output "eks_node_group_role_arn" {
  description = "ARN of the IAM role for the EKS Node Group."
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_cluster_version_output" {
  description = "The Kubernetes version of the EKS cluster."
  value       = aws_eks_cluster.main.version
}

output "eks_node_group_name" {
  description = "The name of the EKS managed node group."
  value       = aws_eks_node_group.main_nodes.node_group_name
}

output "eks_node_group_status" {
  description = "The status of the EKS managed node group."
  value       = aws_eks_node_group.main_nodes.status
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository."
  value       = aws_ecr_repository.nextcloud_app.repository_url
}

output "ebs_csi_driver_role_arn" {
  description = "The ARN of the IAM role for the EBS CSI Driver Service Account."
  value       = aws_iam_role.ebs_csi_driver_role.arn
}
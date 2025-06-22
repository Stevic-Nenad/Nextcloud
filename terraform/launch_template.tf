resource "aws_launch_template" "eks_nodes" {
  name_prefix   = "${lower(var.project_name)}-lt-"
  description   = "Launch template for EKS worker nodes with custom metadata options"

  metadata_options {
    http_tokens                 = "required" # Enforce IMDSv2 for security
    http_put_response_hop_limit = 2          # Increase hop limit for pods
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-eks-launch-template"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
# --- EKS Managed Add-on: AWS EBS CSI Driver ---
# This installs the AWS EBS CSI (Container Storage Interface) Driver, which is the
# modern way for Kubernetes to provision and manage AWS EBS volumes for persistent storage.
#
# Why use the EKS Add-on method?
# - It's managed by AWS, simplifying updates and ensuring compatibility.
# - It integrates seamlessly with Terraform.
# - It's the recommended approach for EKS clusters.
#
# The 'service_account_role_arn' is the most critical part. It links this add-on
# to the specific IAM role we created for it via IRSA, granting it the necessary
# permissions to create/delete/attach EBS volumes on your behalf, without
# ever needing static credentials.

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "aws-ebs-csi-driver"

  # The ARN of the role created in iam_irsa.tf. This connects the driver to its permissions.
  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn

  # This setting prevents conflicts if the add-on already exists, forcing it
  # to adopt the configuration we've defined here in Terraform.
  resolve_conflicts_on_create = "OVERWRITE"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-ebs-csi-driver-addon"
    }
  )

  # Explicitly depend on the OIDC provider to ensure it exists before the add-on is configured.
  depends_on = [
    aws_iam_openid_connect_provider.eks_oidc_provider
  ]
}
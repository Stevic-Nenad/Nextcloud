# --- IAM OIDC Provider for EKS ---
# This establishes the trust relationship between your EKS cluster and AWS IAM.
# It allows IAM to verify tokens issued by your cluster's OIDC provider, which is the
# foundation for IAM Roles for Service Accounts (IRSA).

data "tls_certificate" "eks_oidc_thumbprint" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_thumbprint.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.main.identity[0].oidc[0].issuer

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-eks-oidc-provider"
    }
  )
}

# --- Example IAM Role for EBS CSI Driver Service Account ---
# This is a specific IAM role designed to be assumed by the EBS CSI Driver's Kubernetes Service Account.
# The magic happens in the 'assume_role_policy' (Trust Policy).
#
# Trust Policy Breakdown:
# 1. "Action": "sts:AssumeRoleWithWebIdentity" - This is the specific action for OIDC federation.
# 2. "Principal": It trusts the OIDC provider we created above.
# 3. "Condition": This is the critical part. It ensures that this role can ONLY be assumed by a token
#    whose 'sub' (subject) claim matches the specified Kubernetes Service Account.
#    The format is: system:serviceaccount:<namespace>:<service-account-name>

resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "${var.project_name}-ebs-csi-driver-role"

  # This is the corrected and more robust Trust Policy.
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Principal = {
          # The entity that is allowed to assume the role. In this case, our EKS cluster's OIDC provider.
          Federated = aws_iam_openid_connect_provider.eks_oidc_provider.arn
        },
        # These conditions are the security gates. The request must pass ALL of them.
        Condition = {
          # Gate 1: Check the 'audience' of the token. It must be 'sts.amazonaws.com'.
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:aud" = "sts.amazonaws.com"
          },
          # Gate 2: Check the 'subject' of the token. It must match the specific Kubernetes Service Account.
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-ebs-csi-driver-role"
    }
  )
}

# Attach the AWS-managed policy required for the EBS CSI driver to function.
resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_driver_role.name
}
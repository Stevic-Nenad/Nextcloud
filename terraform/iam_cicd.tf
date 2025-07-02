resource "aws_iam_openid_connect_provider" "github_actions_oidc_provider" {
  # This URL is fixed and is the issuer for all GitHub Actions OIDC tokens.
  url = "https://token.actions.githubusercontent.com"

  # The client ID for GitHub Actions OIDC is always sts.amazonaws.com.
  client_id_list = ["sts.amazonaws.com"]

  # These thumbprints are for the root certificates of the GitHub Actions OIDC provider.
  # This is a security measure to ensure AWS is talking to the real GitHub.
  # These values are provided by GitHub's documentation and may need updating in the future.
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-github-actions-oidc-provider"
    }
  )
}


data "aws_iam_policy_document" "github_actions_trust_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions_oidc_provider.arn]
    }

    # This CONDITION is the most important part. It scopes the trust down to:
    # - ONLY workflows from your specific GitHub repository (`Stevic-Nenad/Nextcloud`).
    # - ONLY workflows running on the `main` branch.
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:Stevic-Nenad/Nextcloud:ref:refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "${var.project_name}-cicd-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_trust_policy.json

  description = "IAM Role to be assumed by GitHub Actions for deploying the Nextcloud app."

  max_session_duration = 3600 # 1 hour

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-github-actions-cicd-role"
    }
  )
}

data "aws_iam_policy_document" "github_actions_permissions" {
  statement {
    actions = [
      # Permissions needed to update the kubeconfig for EKS
      "eks:DescribeCluster"
    ]
    resources = [
      aws_eks_cluster.main.arn
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      # Permissions for Helm/kubectl to interact with the cluster.
      # Very general, but for this project, this is a pragmatic approach.
      "eks:AccessKubernetesApi"
    ]
    resources = [
      aws_eks_cluster.main.arn
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = [
      aws_ecr_repository.nextcloud_app.arn
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "${var.project_name}-cicd-policy"
  description = "Permissions for the GitHub Actions CI/CD pipeline."
  policy      = data.aws_iam_policy_document.github_actions_permissions.json
}

resource "aws_iam_role_policy_attachment" "github_actions_attach_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
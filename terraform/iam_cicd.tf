# This file defines the IAM resources required for the GitHub Actions CI/CD pipeline
# to securely authenticate with AWS using OIDC.

# --- IAM OIDC Provider for GitHub Actions ---
# This resource establishes the trust relationship between your AWS account and GitHub's OIDC provider.
# It only needs to be created once per AWS account. It tells AWS to trust tokens from GitHub.
resource "aws_iam_openid_connect_provider" "github_actions_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"

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

# --- Trust Policy Data Source for the CI/CD Role ---
# This data source constructs the JSON trust policy that defines who can assume our CI/CD role.
data "aws_iam_policy_document" "github_actions_trust_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions_oidc_provider.arn]
    }

    # CRITICAL: This condition scopes the trust down to ONLY workflows from your specific GitHub repository
    # and (optionally) a specific branch, preventing any other repository from assuming this role.
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:Stevic-Nenad/Nextcloud:ref:refs/heads/main"]
    }
  }
}

# --- IAM Role for the CI/CD Pipeline ---
# This is the specific role that our GitHub Actions workflow will assume.
resource "aws_iam_role" "github_actions_role" {
  name               = "${var.project_name}-cicd-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_trust_policy.json
  description        = "IAM Role to be assumed by GitHub Actions for deploying the Nextcloud app and managing infrastructure."
  max_session_duration = 3600 # 1 hour

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-github-actions-cicd-role"
    }
  )
}

# --- Permissions Policy for the CI/CD Role ---
# This data source constructs the JSON permissions policy, adhering to the principle of least privilege.
data "aws_iam_policy_document" "github_actions_permissions" {
  # Permissions to allow Terraform to manage all project resources
  statement {
    sid    = "AllowTerraformToManageProjectResources"
    effect = "Allow"
    actions = [
      "ec2:*",
      "eks:*",
      "rds:*",
      "iam:*", # Needed for creating roles, policies, etc.
      "s3:*",  # Needed for backend state
      "dynamodb:*",
      "ecr:*"
    ]
    # In a real production scenario, this would be scoped down further.
    # For this project, allowing full control over these services is pragmatic.
    resources = ["*"]
  }
}

# --- IAM Policy and Attachment ---
resource "aws_iam_policy" "github_actions_policy" {
  name        = "${var.project_name}-cicd-policy"
  description = "Permissions for the GitHub Actions CI/CD pipeline."
  policy      = data.aws_iam_policy_document.github_actions_permissions.json
}

resource "aws_iam_role_policy_attachment" "github_actions_attach_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
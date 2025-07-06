data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.main.name
}

provider "kubernetes" {
  host  = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.cluster.token
}

data "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  depends_on = [
    aws_eks_node_group.main_nodes,
  ]
}

resource "kubernetes_config_map_v1_data" "aws_auth_patch" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  force = true

  data = {
    "mapRoles" = yamlencode(
      concat(
        yamldecode(data.kubernetes_config_map.aws_auth.data.mapRoles),
        [
          {
            rolearn  = aws_iam_role.github_actions_role.arn
            username = "cicd-github-actions"
            groups = ["system:masters"]
          }
        ]
      )
    )
  }

  depends_on = [
    data.kubernetes_config_map.aws_auth,
  ]
}
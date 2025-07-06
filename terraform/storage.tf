resource "kubernetes_storage_class_v1" "ebs_sc" {
  depends_on = [aws_eks_addon.ebs_csi_driver]

  metadata {
    name = "ebs-sc"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  reclaim_policy      = "Delete"
  allow_volume_expansion = true

  parameters = {
    type = "gp3"
    fsType = "ext4"
  }
}

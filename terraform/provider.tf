provider "aws" {
  region  = var.aws_region
  profile = "nextcloud-project"

  default_tags {
    tags = local.common_tags
  }
}
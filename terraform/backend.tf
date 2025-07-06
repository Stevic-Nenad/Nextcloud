terraform {
  backend "s3" {
    bucket         = "nenad-stevic-nextcloud-tfstate"
    key            = "nextcloud-project/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "nenad-stevic-nextcloud-tfstate-lock"
    encrypt        = true
  }
}
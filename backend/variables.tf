variable "aws_region" {
  default = "eu-central-1"
}

variable "project_name" {
  default = "Nextcloud-Backend"
}

variable "terraform_s3_backend_bucket_name" {
  description = "A globally unique name for the S3 bucket that will store Terraform state."
  type        = string
  default     = "nenad-stevic-nextcloud-tfstate"
}

variable "terraform_dynamodb_lock_table_name" {
  description = "Name for the DynamoDB table used for Terraform state locking."
  type        = string
  default     = "nenad-stevic-nextcloud-tfstate-lock"
}

locals {
  common_tags = {
    Project   = var.project_name
    Purpose   = "Terraform-State-Backend"
    ManagedBy = "Terraform"
  }
}
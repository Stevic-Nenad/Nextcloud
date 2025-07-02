variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]

  validation {
    // Ensure at least two AZs are provided for the subnets as per requirements
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones must be specified."
  }
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "project_name" {
  description = "A name for the project, used for tagging resources."
  type        = string
  default     = "Nextcloud"
}

variable "eks_cluster_version" {
  description = "Desired Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.33" //newest as of 01.06.2025
}

variable "eks_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates from which CIDR blocks find users matching clusters to ARN."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_node_instance_types" {
  description = "Instance types for the EKS_node group."
  type        = list(string)
  default     = ["m6i.large"]
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository for the application images."
  type        = string
  default     = "nextcloud-app"
}

variable "rds_pg_version" {
  description = "PostgreSQL engine version for RDS."
  type        = string
  default     = "17.2"
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "The initial allocated storage for the RDS instance (in GB)."
  type        = number
  default     = 20
}

variable "rds_master_username" {
  description = "The master username for the RDS database."
  type        = string
  default     = "nextcloudadmin"
}

variable "rds_db_name" {
  description = "The name of the database to create within the RDS instance."
  type        = string
  default     = "nextclouddb"
}

variable "rds_multi_az_enabled" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = true
}
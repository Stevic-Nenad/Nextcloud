# ---------------------------------------------------------------------------------------------------------------------
# General Project Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region where all resources for the project will be deployed."
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "A name for the project, used as a prefix for tagging and naming resources."
  type        = string
  default     = "Nextcloud"
}

# ---------------------------------------------------------------------------------------------------------------------
# Networking Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "vpc_cidr_block" {
  description = "The main CIDR block for the Virtual Private Cloud (VPC)."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "A list of Availability Zones to use for creating subnets, ensuring high availability."
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones must be specified for high availability."
  }
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets, one for each Availability Zone."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets, one for each Availability Zone."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# ---------------------------------------------------------------------------------------------------------------------
# EKS Cluster Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "eks_cluster_version" {
  description = "The desired Kubernetes version for the EKS cluster control plane."
  type        = string
  default     = "1.29" # As of mid-2024, 1.29 is a stable and supported version.
}

variable "eks_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates from which CIDR blocks find users matching clusters to ARN."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "eks_node_instance_types" {
  description = "A list of EC2 instance types to use for the EKS worker nodes."
  type        = list(string)
  default     = ["t3.medium"] # A good balance of cost and performance for this project.
}

# ---------------------------------------------------------------------------------------------------------------------
# ECR Repository Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "ecr_repository_name" {
  description = "The name for the ECR repository. Although we use a public image, this is for demonstration."
  type        = string
  default     = "nextcloud-app"
}

# ---------------------------------------------------------------------------------------------------------------------
# RDS Database Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "rds_pg_version" {
  description = "PostgreSQL engine version for RDS."
  type        = string
  default     = "17.2"
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance. db.t3.micro is eligible for the AWS Free Tier."
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
  description = "The name of the database to be created within the RDS instance."
  type        = string
  default     = "nextclouddb"
}

variable "rds_multi_az_enabled" {
  description = "Specifies if the RDS instance should be deployed in a Multi-AZ configuration for high availability."
  type        = bool
  default     = true
}
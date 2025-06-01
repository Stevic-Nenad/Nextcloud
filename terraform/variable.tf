variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = ["eu-central-1a", "eu-central-1b"]

  validation {
    // Ensure at least two AZs are provided for the subnets as per requirements
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones must be specified."
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
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
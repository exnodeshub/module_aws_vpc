# VPC
variable "vpc_tags" {
    description = "The VPC tags."
    default     = {
        Owner       = "TWS Solutions"
        Environment = "production"
        Name        = "TWS Solutions VPC"
    }
}
variable "region" {
    description = "Region"
    type        = string
}

# networking
variable "general_public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "general_public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "general_private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "general_private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "general_availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-2b", "us-east-2c"]
}

# IAM
variable "env_name" {
  description = "Define environment name"
  type = string
}
variable "ecs_task_policy" {
  description = "ECS task policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
variable "ecs_codedeploy_policy" {
  description = "ECS codedeploy policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# S3
variable "s3_private_arn" {
  description = "S3 private bucket arn"
  type = string
}

# Key pair
variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  type        = string
}
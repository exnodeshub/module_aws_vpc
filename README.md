# module_aws_vpc  
My module vpc aws

## Getting started  
config git credentical for private repo   
href: https://gitlab.com/exnodes-new/terraform-core/-/tree/master/modules/module_aws_vpc?ref_type=heads

add module    
example:       
```JavaScript

module "example_vpc" {
  source = "./modules/module_aws_vpc"
  ssh_pubkey_file = "~/.ssh/id_rsa.pub"
  region = "your region, Ex: `us-east-2`"
  s3_private_arn = "your s3 private arn"
  env_name = "your environment name, Ex: `prod`"
  ecs_task_policy = "your ecs task policy"
  ecs_codedeploy_policy = "your ecs code deploy policy"
  vpc_tags = {
      Owner       = "Exnodes"
      Environment = "production"
      Name        = "EXN VPC"
  }
}
```

# Input 
```JavaScript
# VPC
variable "vpc_tags" {
    description = "The VPC tags."
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
}
variable "ecs_codedeploy_policy" {
  description = "ECS codedeploy policy"
  type        = string
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
```

# Output 
```JavaScript
# VPC
output "vpc_id" {
  description = "VPC ID"
  value     = aws_vpc.general-vpc.id
  sensitive = false
}
# IAM
output "iam_access_account_id" {
  description = "Get IAM access key id from current account"
  value = data.aws_caller_identity.current.account_id
}
output "ecs_role_arn" {
  description = "Get ecs role arn"
  value = aws_iam_role.task-role.arn
}
output "ecs_tasks_role_arn" {
  description = "ECS task role arn"
  value       = aws_iam_role.ecs-tasks-role.arn
}
output "execution_role_arn" {
  description = "Get execution role arn"
  value = aws_iam_role.ecs-tasks-role.arn
}
output "iam_role_codedeploy_arn" {
  description = "Get iam rolecodedeploy"
  value = aws_iam_role.general-codedeploy.arn
}
output "iam_role_codepipeline_arn" {
  description = "Get iam codepipeline"
  value = aws_iam_role.general-codepipeline.arn
}
output "iam_role_codebuild_arn" {
  description = "Get iam codepipeline"
  value = aws_iam_role.general-codebuild.arn
}
# Subnet
output "public-subnet-1" {
  description = "Get public subnet 1 id"
  value = aws_subnet.general-public-subnet-1.id
}
output "public-subnet-2" {
  description = "Get public subnet 2 id"
  value = aws_subnet.general-public-subnet-2.id
}
output "private-subnet-1" {
  description = "Get private subnet 1 id"
  value = aws_subnet.general-private-subnet-1.id
}
output "private-subnet-2" {
  description = "Get private subnet 2 id"
  value = aws_subnet.general-private-subnet-2.id
}
# Key pair
output "key-pair_anr" {
  description = "Get key pair arn"
  value = aws_key_pair.general-key-pair.arn
}
```
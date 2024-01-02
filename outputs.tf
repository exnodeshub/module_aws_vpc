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
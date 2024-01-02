data "aws_caller_identity" "current" {}
# ################################################
# # Key pair
# ################################################
resource "aws_key_pair" "general-key-pair" {
  key_name   = "${var.env_name}_key_pair"
  public_key = file(var.ssh_pubkey_file)
}

################################################
# ECS ROLE
################################################
data "aws_iam_policy_document" "general-ecs-tasks" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ecs-tasks-role" {
  assume_role_policy = data.aws_iam_policy_document.general-ecs-tasks.json
  name               = "${var.env_name}-tasks-role"
  tags = {
    Name = "${var.env_name}-tasks-role"
  }
}
data "aws_iam_policy" "amazon-ecs-task-exec" {
  arn = var.ecs_task_policy
}
resource "aws_iam_role_policy_attachment" "amazon-ecs-task-exec" {
  policy_arn = data.aws_iam_policy.amazon-ecs-task-exec.arn
  role       = aws_iam_role.ecs-tasks-role.name
}
resource "aws_iam_role_policy" "ecs-tasks-role-policy" {
  name   = "${var.env_name}-tasks-role-policy"
  policy = templatefile("policies/ecs-service-role-policy.json", { bucket_arn = var.s3_private_arn, bucket_arn_2 = var.s3_private_arn })
  role   = aws_iam_role.ecs-tasks-role.id
}
resource "aws_iam_role" "task-role" {
  name = "task-role-${var.env_name}"
  assume_role_policy = data.aws_iam_policy_document.general-ecs-tasks.json
  inline_policy {
    name = "task-ssmmessages"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Effect = "Allow",
          Action = [
            "s3:GetObject"
          ],
          Resource = [
            "*",
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "s3:GetBucketLocation"
          ],
          Resource = [
            "*"
          ]
        }
      ]
    })
  }
  tags = {
    Name = "Task role"
  }
}

################################################
# CODEBUILD ROLE
################################################
data "aws_iam_policy_document" "general-codebuild" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "general-codebuild" {
  assume_role_policy = data.aws_iam_policy_document.general-codebuild.json
  name               = "${var.env_name}-codebuild"
  tags = {
    Name = "${var.env_name}-codebuild"
  }
}
data "template_file" "general-codebuild-policy" {
  template = file("policies/general-codebuild-policy.tpl")
  vars = {
    aws_account_id = data.aws_caller_identity.current.account_id
    bucket_arn     = var.s3_private_arn
    region         = var.region
  }
}
resource "aws_iam_role_policy" "general-codebuild-policy" {
  name   = "codebuild-policy-${var.env_name}"
  policy = data.template_file.general-codebuild-policy.rendered
  role   = aws_iam_role.general-codebuild.id
}

################################################
# CODEDEPLOY ROLE
################################################
data "aws_iam_policy" "general-codedeploy" {
  arn = var.ecs_codedeploy_policy
}
data "aws_iam_policy_document" "general-codedeploy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "general-codedeploy" {
  assume_role_policy = data.aws_iam_policy_document.general-codedeploy.json
  name               = "${var.env_name}-codedeploy"
  tags = {
    Name = "${var.env_name}-codedeploy"
  }
}
resource "aws_iam_role_policy_attachment" "general-codedeploy" {
  policy_arn = data.aws_iam_policy.general-codedeploy.arn
  role       = aws_iam_role.general-codedeploy.name
}
data "template_file" "general-codedeploy-policy" {
  template = file("policies/general-codedeploy-policy.tpl")
  vars = {
    bucket_arn = var.s3_private_arn
  }
}
resource "aws_iam_role_policy" "codedeploy" {
  name   = "codedeploy-policy-${var.env_name}"
  policy = data.template_file.general-codedeploy-policy.rendered
  role   = aws_iam_role.general-codedeploy.id
}

################################################
# CODEPIPELINE ROLE
################################################
data "aws_iam_policy_document" "general-codepipeline" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "general-codepipeline" {
    assume_role_policy = data.aws_iam_policy_document.general-codepipeline.json
    name               = "${var.env_name}-codepipeline"
    tags = {
        Name = "${var.env_name}-codepipeline"
    }
}
data "template_file" "general-codepipeline-policy" {
    template = file("policies/general-codepipeline-policy.tpl")
}
resource "aws_iam_role_policy" "general-codepipeline-policy" {
    name   = "codepipeline-policy-${var.env_name}"
    policy = data.template_file.general-codepipeline-policy.rendered
    role   = aws_iam_role.general-codepipeline.id
}
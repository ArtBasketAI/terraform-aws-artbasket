resource "aws_iam_role" "ecr_access_role" {
  name = "ecr_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecr_access" {
  name   = "ecr_access_policy"
  role   = aws_iam_role.ecr_access_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken",
        ],
        Resource = "*"
        Effect = "Allow"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ecr_access_profile" {
  name = "ecr_access_profile"
  role = aws_iam_role.ecr_access_role.name
}

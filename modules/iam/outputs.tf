output "ecr_access_profile_arn" {
  description = "The ARN of the IAM instance profile to access ECR"
  value       = aws_iam_instance_profile.ecr_access_profile.arn
}

output "ec2_role_name" {
  value = aws_iam_role.ecr_access_role.name
}
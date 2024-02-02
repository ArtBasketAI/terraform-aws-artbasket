output "ecr_access_profile_arn" {
  description = "The ARN of the IAM instance profile to access ECR"
  value       = aws_iam_instance_profile.ecr_access_profile.arn
}

output "ecr_access_profile_arn" {
  value = aws_iam_instance_profile.ecr_access_profile.arn
}
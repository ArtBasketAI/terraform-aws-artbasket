# modules/ec2/variables.tf

variable "instance_count" {
  description = "Number of EC2 instances"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instances"
}

variable "sg_id" {
  description = "Security group ID for the EC2 instances"
}

variable "key_name" {
  description = "Key name for SSH access to EC2 instances"
}

variable "target_group_arn" {
  description = "ARN of the target group for the load balancer"
}

variable "iam_instance_profile" {
  description = "ARN of the IAM instance profile for the EC2 instance"
  type        = string
}

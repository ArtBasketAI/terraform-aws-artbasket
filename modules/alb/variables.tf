# modules/alb/variables.tf

variable "sg_id" {
  description = "Security group ID for the ALB"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate"
  type        = string
}
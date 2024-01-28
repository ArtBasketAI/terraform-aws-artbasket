variable "security_group_id" {
  description = "The ID of the security group for the load balancer."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the load balancer."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

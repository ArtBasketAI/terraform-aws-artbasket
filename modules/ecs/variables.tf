variable "execution_role_arn" {
  description = "ARN of the execution role that the ECS service will assume."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service."
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ECS service."
  type        = string
}

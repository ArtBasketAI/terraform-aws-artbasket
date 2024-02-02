# modules/vpc/variables.tf

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"] # Example subnet CIDRs
}

variable "availability_zones" {
  description = "List of Availability Zones in which to create subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
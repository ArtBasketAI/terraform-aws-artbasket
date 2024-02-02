# variables.tf

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c55b159cbfafe1f0" # Placeholder AMI ID, replace with actual
}

variable "instance_count" {
  description = "Number of EC2 instances"
  default     = 1
}

# modules/route53/variables.tf

variable "domain_name" {
  description = "The domain name for the Route 53 zone"
}

variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
}

variable "alb_zone_id" {
  description = "The Zone ID of the Application Load Balancer"
}

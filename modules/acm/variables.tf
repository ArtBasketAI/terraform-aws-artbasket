variable "domain_name" {
  description = "The primary domain name for the certificate"
}

variable "subject_alternative_names" {
  description = "List of alternative domain names for the certificate"
  type        = list(string)
}

variable "route53_zone_id" {
  description = "The Zone ID of the hosted zone in Route 53"
}

# main.tf

provider "aws" {
  region = "us-east-1" # AWS region set to US East (N. Virginia)
}

# AWS key pair for EC2 instance SSH access
resource "aws_key_pair" "deployer" {
  key_name   = "ec2-deployer-key"
  public_key = file("~/.ssh/id_ed25519.pub") # Path to your ed25519 public key
}

# Module for VPC setup
module "vpc" {
  source = "./modules/vpc"
  # Add additional parameters if needed
}

# Module for Security Group setup
module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

# Module for IAM setup
module "iam" {
  source = "./modules/iam"
  # Add any required variables for the iam module here
}

# Module for EC2 instance setup
module "ec2" {
  source               = "./modules/ec2"
  instance_count       = var.instance_count
  instance_type        = var.instance_type
  ami_id               = var.ami_id
  subnet_id            = module.vpc.subnet_ids[0]
  sg_id                = module.security_group.sg_id
  key_name             = aws_key_pair.deployer.key_name
  target_group_arn     = module.alb.target_group_arn
  iam_instance_profile = module.iam.ecr_access_profile_arn
  ecr_access_role_name = module.iam.ecr_access_role_name
}

# Module for Application Load Balancer setup
module "alb" {
  source     = "./modules/alb"
  subnet_ids = module.vpc.subnet_ids
  sg_id      = module.security_group.alb_sg_id
  vpc_id     = module.vpc.vpc_id
  # certificate_arn = module.acm.certificate_arn
}

# # There seems to be an issue with the setup of route 53 and acm so will comment them out 

# # Module for Route 53 setup
# module "route53" {
#   source       = "./modules/route53"
#   domain_name  = "artbasket.org"
#   alb_dns_name = module.alb.alb_dns_name
#   alb_zone_id  = module.alb.alb_zone_id # Ensure your ALB module provides this output
# }

# # Module for Amazon Certificate Management for Https/SSL
# module "acm" {
#   source                    = "./modules/acm"
#   domain_name               = "artbasket.org"
#   subject_alternative_names = ["www.artbasket.org"]
#   route53_zone_id           = module.route53.route53_zone_id
# }

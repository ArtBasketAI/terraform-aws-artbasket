module "vpc" {
  source = "../../modules/vpc"

  cidr_block    = "10.0.0.0/16"
  subnet_a_cidr = "10.0.1.0/24"
  subnet_b_cidr = "10.0.2.0/24"
}

module "security" {
  source = "../../modules/security"

  vpc_id = module.vpc.artbasket_vpc.id
}

module "ecs" {
  source = "../../modules/ecs"

  cluster_id         = aws_ecs_cluster.artbasket_cluster.id
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  subnet_ids         = [module.vpc.subnet_a.id, module.vpc.subnet_b.id]
  security_group_id  = module.security.artbasket_sg.id
}

module "alb" {
  source = "../../modules/alb"

  security_group_id = module.security.artbasket_sg.id
  subnet_ids        = [module.vpc.subnet_a.id, module.vpc.subnet_b.id]
  vpc_id            = module.vpc.artbasket_vpc.id
}

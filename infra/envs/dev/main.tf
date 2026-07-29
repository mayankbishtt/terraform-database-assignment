module "network" {

  source = "../../modules/network"

  vpc_cidr = var.vpc_cidr

  public_subnet_1 = var.public_subnet_1

  public_subnet_2 = var.public_subnet_2

  private_subnet_1 = var.private_subnet_1

  private_subnet_2 = var.private_subnet_2

}

module "alb" {

  source = "../../modules/alb"

  vpc_id = module.network.vpc_id

  public_subnet_ids = module.network.public_subnet_ids

}

module "ecs" {

  source = "../../modules/ecs"

  vpc_id = module.network.vpc_id

  private_subnet_ids = module.network.private_subnet_ids

  target_group_arn = module.alb.target_group_arn

  alb_security_group_id = module.alb.alb_security_group_id

}
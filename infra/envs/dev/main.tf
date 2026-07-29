module "network" {

  source = "../../modules/network"

  vpc_cidr = var.vpc_cidr

  public_subnet_1 = var.public_subnet_1

  public_subnet_2 = var.public_subnet_2

  private_subnet_1 = var.private_subnet_1

  private_subnet_2 = var.private_subnet_2

}
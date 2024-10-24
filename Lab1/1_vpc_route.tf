data "aws_availability_zones" "available" {}

module "defaults" {
  source                  = "./modules/defaults"
  availability_zone_names = data.aws_availability_zones.available.names
  vpc_cidr_block          = var.vpc_cidr_block
  max_availabilty_zones   = var.max_availabilty_zones
}

module "vpc" {
  source          = "./modules/vpc"
  name            = var.group_name
  cidr_block      = var.vpc_cidr_block
  public_subnets  = module.defaults.public_subnets
  private_subnets = module.defaults.private_subnets
}

# Route tables for public and private subnets
resource "aws_route" "internet_gateway" {
  count                  = length(module.vpc.public_route_table_ids)
  route_table_id         = element(module.vpc.public_route_table_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.internet_gateway_id
}

resource "aws_route" "nat_gateway" {
  count                  = length(module.vpc.private_route_table_ids)
  route_table_id         = element(module.vpc.private_route_table_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  # use the first NAT Gateway within the same AZ
  nat_gateway_id = module.vpc.nat_gateway_ids[module.defaults.private_subnets[count.index].availability_zone][0]
}

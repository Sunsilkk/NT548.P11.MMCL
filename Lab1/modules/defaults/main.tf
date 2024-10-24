# Define default values for availability zones, public and private subnets
locals {
  # Limit the number of availability zones to use
  azs = slice(var.availability_zone_names, 0, var.max_availabilty_zones)

  # Create a list of public and private subnets
  public_subnets = [
    for k, az in local.azs : {
      # 10.0.0.0/24 for AZ 1, 10.0.1.0/24 for AZ 2, etc.
      cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, k)
      availability_zone = az
      # designate NAT Gateway for the first public subnet within the first AZ
      nat_gateway = k == 0
    }
  ]

  private_subnets = [
    for k, az in local.azs : {
      # if there are 2 AZs,
      # private subnet for AZ 1: 10.0.2.0/24 and AZ 2: 10.0.3.0/24
      cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, k + var.max_availabilty_zones)
      availability_zone = az
    }
  ]
}

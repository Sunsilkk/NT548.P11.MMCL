data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  exclude_ssh_ip = var.exclude_ssh_ip != null ? var.exclude_ssh_ip : chomp(data.http.myip.response_body)
}

module "default_sg" {
  source = "./modules/security_groups"

  name        = "${var.group_name}-default-sg"
  description = "Default security group for VPC"
  vpc_id      = module.vpc.id

  ingress_rules = [
    {
      description     = "Allow all incoming traffic within the VPC"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = [var.vpc_cidr_block]
      security_groups = []
    }
  ]

  egress_rules = [
    {
      description     = "Allow all outbound traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}

module "private_ec2_sg" {
  source = "./modules/security_groups"

  name        = "${var.group_name}-private-ec2-sg"
  description = "Security group for private EC2 instances"
  vpc_id      = module.vpc.id

  ingress_rules = [
    {
      description     = "Allow SSH from public EC2 instances"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.public_ec2_sg.id]
    }
  ]

  egress_rules = [
    {
      description     = "Allow all outbound traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}

module "public_ec2_sg" {
  source = "./modules/security_groups"

  name        = "${var.group_name}-public-ec2-sg"
  description = "Security group for public EC2 instances"
  vpc_id      = module.vpc.id

  ingress_rules = [
    {
      description     = "Allow SSH from specific IP"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["${local.exclude_ssh_ip}/32"]
      security_groups = []
    }
  ]

  egress_rules = [
    {
      description     = "Allow all outbound traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}

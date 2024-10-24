data "aws_ami" "default_image" {
  most_recent = true
  owners      = var.image_owners

  filter {
    name   = "name"
    values = [var.image_name]
  }
}

module "public_ec2" {
  source = "./modules/ec2"

  count = length(module.vpc.availability_zones)

  name          = "${var.group_name}-public-ec2"
  ami_id        = data.aws_ami.default_image.id
  instance_type = var.instance_type
  key_name      = var.key_name

  availability_zone  = element(module.vpc.availability_zones, count.index)
  subnet_id          = element(module.vpc.public_subnet_ids, count.index)
  security_group_ids = [module.public_ec2_sg.id]

  associate_public_ip = true
}

module "private_ec2" {
  source = "./modules/ec2"

  count = length(module.vpc.availability_zones)

  name          = "${var.group_name}-private-ec2"
  ami_id        = data.aws_ami.default_image.id
  instance_type = var.instance_type
  key_name      = var.key_name

  availability_zone  = element(module.vpc.availability_zones, count.index)
  subnet_id          = element(module.vpc.private_subnet_ids, count.index)
  security_group_ids = [module.private_ec2_sg.id]

  associate_public_ip = false
}

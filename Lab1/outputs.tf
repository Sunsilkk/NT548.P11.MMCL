# Defaults Outputs
output "default_availibility_zones" {
  description = "A list of availability zones in use"
  value       = module.defaults.availibility_zones
}

output "default_public_subnets" {
  description = "List of public subnets"
  value       = module.defaults.public_subnets
}

output "default_private_subnets" {
  description = "List of private subnets"
  value       = module.defaults.private_subnets
}

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.id
}

output "vpc_public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "vpc_private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "vpc_internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "vpc_nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_ids
}

output "vpc_availability_zones" {
  description = "A list of availability zones in use"
  value       = module.vpc.availability_zones
}

# EC2 Outputs
output "public_instance_ids" {
  description = "List of IDs of public EC2 instances"
  value       = module.public_ec2[*].id
}

output "public_instance_public_ips" {
  description = "List of public IP addresses of public EC2 instances"
  value       = module.public_ec2[*].public_ip
}

output "private_instance_ids" {
  description = "List of IDs of private EC2 instances"
  value       = module.private_ec2[*].id
}

output "private_instance_private_ips" {
  description = "List of private IP addresses of private EC2 instances"
  value       = module.private_ec2[*].private_ip
}

# Security Group Outputs

output "public_security_group_id" {
  description = "ID of the public security group"
  value       = module.public_ec2_sg.id
}

output "public_security_group_name" {
  description = "Name of the public security group"
  value       = module.public_ec2_sg.name
}

output "public_security_group_vpc_id" {
  description = "VPC ID of the public security group"
  value       = module.public_ec2_sg.vpc_id
}

output "public_security_group_ingress_rules" {
  description = "List of ingress rules for the public security group"
  value       = module.public_ec2_sg.ingress_rules
}

output "public_security_group_egress_rules" {
  description = "List of egress rules for the public security group"
  value       = module.public_ec2_sg.egress_rules
}

output "private_security_group_id" {
  description = "ID of the private security group"
  value       = module.private_ec2_sg.id
}

output "private_security_group_name" {
  description = "Name of the private security group"
  value       = module.private_ec2_sg.name
}

output "private_security_group_vpc_id" {
  description = "VPC ID of the private security group"
  value       = module.private_ec2_sg.vpc_id
}

output "private_security_group_ingress_rules" {
  description = "List of ingress rules for the private security group"
  value       = module.private_ec2_sg.ingress_rules
}

output "private_security_group_egress_rules" {
  description = "List of egress rules for the private security group"
  value       = module.private_ec2_sg.egress_rules
}

# SSH Key Outputs

output "ssh_key_id" {
  description = "ID of the created SSH key"
  value       = module.ssh_key.id
}

output "ssh_key_name" {
  description = "Name of the created SSH key"
  value       = module.ssh_key.name
}

output "ssh_key_public_key" {
  description = "Public key of the created SSH key"
  value       = module.ssh_key.public_key
}

output "ssh_key_private_key" {
  description = "Private key of the created SSH key"
  value       = module.ssh_key.private_key
  sensitive   = true
}

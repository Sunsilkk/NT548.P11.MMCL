variable "group_name" {
  description = "Name of the group"
  type        = string
  default     = "sunsilk"
}

variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "max_availabilty_zones" {
  description = "Maximum number of availability zones to use"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "image_name" {
  description = "AMI name to use for the EC2 instance"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240927"
}

variable "image_owners" {
  description = "Owners of the AMI to use for the EC2 instance"
  type        = list(string)
  default     = ["099720109477"] # Canonical
}

variable "exclude_ssh_ip" {
  description = "IP address of the user for SSH access. If null, use the current IP address"
  type        = string
  default     = null
}

variable "key_name" {
  description = "Name of the key pair for SSH access"
  type        = string
  default     = "id_sunsilk_lab1"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = ".ssh"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "cidr_block" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
  nullable    = false
}

variable "public_subnets" {
  description = "List of public subnets"
  type = list(object({
    cidr_block        = string
    availability_zone = string
    nat_gateway       = bool
  }))
}

variable "private_subnets" {
  description = "List of private subnets"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "tags" {
  description = "A map of tags to add to the VPC"
  type        = map(string)
  default     = {}
}

variable "igw_tags" {
  description = "A map of tags to add to the internet gateway"
  type        = map(string)
  default     = {}
}

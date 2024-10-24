variable "availability_zone_names" {
  description = "Availability zone names to use for the instances"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "max_availabilty_zones" {
  description = "Maximum number of availability zones to use"
  type        = number
}

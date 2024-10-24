output "availibility_zones" {
  description = "A list of availability zones in use"
  value       = local.azs
}

output "public_subnets" {
  description = "List of public subnets"
  value       = local.public_subnets
}

output "private_subnets" {
  description = "List of private subnets"
  value       = local.private_subnets
}

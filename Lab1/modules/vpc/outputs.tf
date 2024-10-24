locals {
  azs = distinct(concat(
    [for subnet in var.public_subnets : subnet.availability_zone],
    [for subnet in var.private_subnets : subnet.availability_zone],
  ))
  # hacky :(
  nat_gateway_ids = {
    for az in local.azs :
    az => [
      for i in range(length(local.nat_gateway_subnets)) :
      aws_nat_gateway.this[i].id
      if local.nat_gateway_subnets[i].availability_zone == az
    ]
  }
}

output "id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "public_route_table_ids" {
  description = "ID of the public route table"
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "ID of the private route table"
  value       = aws_route_table.private[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = length(local.nat_gateway_subnets) > 0 ? aws_internet_gateway.this[0].id : null
}

output "nat_gateway_ids" {
  description = "Map of availability zones to IDs of NAT Gateways"
  value       = local.nat_gateway_ids
}

output "availability_zones" {
  description = "A list of availability zones in use"
  value       = local.azs
}

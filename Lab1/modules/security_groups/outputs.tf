output "id" {
  description = "ID of the security group"
  value       = aws_security_group.this.id
}

output "name" {
  description = "Name of the security group"
  value       = aws_security_group.this.name
}

output "vpc_id" {
  description = "VPC ID of the security group"
  value       = aws_security_group.this.vpc_id
}

output "ingress_rules" {
  description = "List of ingress rules"
  value       = module.ingress_rules.out
}

output "egress_rules" {
  description = "List of egress rules"
  value       = module.egress_rules.out
}

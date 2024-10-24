output "name" {
  description = "Name of the created key pair"
  value       = aws_key_pair.this.key_name
}

output "id" {
  description = "ID of the created key pair"
  value       = aws_key_pair.this.key_pair_id
}

output "public_key" {
  description = "Public key of the created key pair"
  value       = aws_key_pair.this.public_key
}

output "private_key" {
  description = "Generated private key in OpenSSH format if created"
  value       = var.generate_private_key ? tls_private_key.this[0].private_key_openssh : ""
  sensitive   = true
}

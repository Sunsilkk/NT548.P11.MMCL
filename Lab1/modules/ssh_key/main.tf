resource "tls_private_key" "this" {
  count     = var.generate_private_key ? 1 : 0
  algorithm = var.private_key_algorithm
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.generate_private_key ? trimspace(tls_private_key.this[0].public_key_openssh) : var.public_key
  tags       = var.tags

  lifecycle {
    precondition {
      condition     = var.generate_private_key ? var.public_key == "" : true
      error_message = "Public key must be empty when generate_private_key is true"
    }
    precondition {
      condition     = var.generate_private_key ? true : var.public_key != ""
      error_message = "Public key must not be empty when generate_private_key is false"
    }
  }
}

module "ssh_key" {
  source               = "./modules/ssh_key"
  key_name             = var.key_name
  generate_private_key = true
}

# Create a local file with the private key in OpenSSH format
resource "local_file" "private_key" {
  content         = module.ssh_key.private_key
  filename        = "${var.public_key_path}/${var.key_name}"
  file_permission = "0600"
}

# Create a local file with the public key in OpenSSH format
resource "local_file" "public_key" {
  content         = module.ssh_key.public_key
  filename        = "${var.public_key_path}/${var.key_name}.pub"
  file_permission = "0644"
}

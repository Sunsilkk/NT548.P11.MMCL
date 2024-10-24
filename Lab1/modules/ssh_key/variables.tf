variable "key_name" {
  description = "Name for the key pair"
  type        = string
  default     = null
}

variable "public_key" {
  description = "Public key to use for the key pair"
  type        = string
  default     = ""
}

variable "generate_private_key" {
  description = "Whether to generate a new private key"
  type        = bool
  default     = false
}

variable "private_key_algorithm" {
  description = "Name of the algorithm to use when generating the private key. Currently-supported values are: RSA, ECDSA, ED25519."
  type        = string
  default     = "ED25519"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

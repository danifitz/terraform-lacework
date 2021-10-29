resource "local_file" "ssh" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.root}/ssh.key"
  file_permission = "0400"
}

resource "random_id" "id" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm   = "RSA"
  rsa_bits = "4096"
}

resource "aws_key_pair" "ssh" {
  key_name   = "${random_id.id.hex}-ssh"
  public_key = tls_private_key.ssh.public_key_openssh
  tags = {}
}
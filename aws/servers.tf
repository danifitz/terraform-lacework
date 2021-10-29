resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
  
  metadata_options {
    http_endpoint               = "disabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  
  tags = {
    Name = "HelloInstance"
  }

  provisioner "remote-exec" {
    connection {
      user        = "ubuntu"
      private_key = tls_private_key.ssh.private_key_pem
      host        = self.public_ip
    }

    inline = [
      "curl -sSL https://github.com/lacework/lacework-agent-releases/releases/download/v4.3.0/4.3.0.5556.tgz > /tmp/4.3.0.5556.tgz",
      "tar -xf /tmp/4.3.0.5556.tgz -C /tmp/",
      "chmod +x /tmp/4.3.0.5556/install.sh",
      "export token=${var.lacework_token}",
      "sed -i.bak \"s/ARG1=\\$1/ARG1=$${token}/g\" /tmp/4.3.0.5556/install.sh",
      "sudo /tmp/4.3.0.5556/install.sh",
      "rm /tmp/4.3.0.5556.tgz && rm -rf /tmp/4.3.0.5556",
    #   "curl -sSL https://s3-us-west-2.amazonaws.com/www.lacework.net/download/4.2.0.218_2021-08-27_release-v4.2_918a6d2e7e45c361fce5e46d6f43134203be86ff/install.sh > /tmp/install.sh",
    #   "chmod +x /tmp/install.sh",
    #   "sudo /tmp/install.sh -U https://api.lacework.net ${var.lacework_token}",
    #   "rm -rf /tmp/lw-install.sh"
    ]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
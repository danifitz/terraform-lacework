data "aws_vpc" "selected" {
  default = true
}

resource "aws_security_group" "allow_traffic" {
  name   = "${random_id.id.hex}-allow-traffic"
  vpc_id = data.aws_vpc.selected.id

  ingress = [{
    description      = "SSH from 0.0.0.0/0"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  egress = [{
    description      = "Lets talk to the world!"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  tags = {}
}
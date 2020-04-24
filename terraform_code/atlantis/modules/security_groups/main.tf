resource "aws_security_group" "sg_allow_ssh" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "sg_name_allow_ssh"
  }
}

resource "aws_security_group" "sg_atlantis_instance_allow_ssh" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = [aws_security_group.sg_allow_ssh.id]
  }

  ingress {
    from_port   = 4141
    to_port = 4141
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags ={
    Name = "sg_name_allow_ssh_to_atlantis_instance"
  }
}

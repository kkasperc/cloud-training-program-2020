resource "aws_security_group" "sg_allow_ssh" {
  vpc_id = aws_vpc.AWS_101.id #Reference to the VPC

  ingress {
    from_port = 22
    protocol = tcp
    to_port = 22
    cidr_blocks = ["31.182.230.160/32"]
  }
  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = var.sg_name_allow_ssh
  }
}

resource "aws_security_group" "sg_atlantis_instance_allow_ssh" {
  vpc_id = aws_vpc.a
  ingress {
    from_port = 22
    protocol = tcp
    to_port = 22
    security_groups = [aws_security_group.sg_allow_ssh.id]
  }
  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags ={
    Name = var.sg_name_allow_ssh_to_atlantis_instance
  }
}

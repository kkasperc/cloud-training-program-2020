#BASTION HOST
resource "aws_instance" "BASTION_HOST" {
  ami = var.ami_instance
  instance_type = var.instance_type
  availability_zone = var.av_zone
  depends_on = [aws_subnet.subnet1_bastionhost]
  subnet_id = aws_subnet.subnet1_bastionhost.id
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh.id]
  associate_public_ip_address = "true"
  key_name = var.key_name
  tags ={
    Name = "BASTION_HOST"
  }
}


#APPLICATION SERVER - non public IP
resource "aws_instance" "ATLANTIS_HOST" {
  ami = var.ami_instance
  instance_type = var.instance_type
  availability_zone = var.av_zone
  depends_on = [aws_subnet.subnet2_atlantis]
  subnet_id = aws_subnet.subnet2_atlantis.id
  associate_public_ip_address = "false"
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_appserver_allow]
  tags ={
    Name = "ATLANTIS_HOST"
  }
}

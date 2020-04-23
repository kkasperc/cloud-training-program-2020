#BASTION HOST
resource "aws_instance" "BASTION_HOST" {
  ami = var.ami_instance
  instance_type = var.instance_type
  availability_zone = var.av_zone
  depends_on = [var.bastion_host_subnet]
  subnet_id = var.bastion_host_subnet_id
  vpc_security_group_ids = [var.sg_bastion_host_id]
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
  depends_on = [var.atlantis_subnet]
  subnet_id = var.atlantis_subnet_id
  associate_public_ip_address = "false"
  key_name = var.key_name
  vpc_security_group_ids = [var.sg_atlantis_id]
  tags ={
    Name = "ATLANTIS_HOST"
  }
}

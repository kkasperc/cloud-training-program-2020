module "networking" {
  source = "../network"
}

##################################################################################
# VARIABLES
##################################################################################


##################################################################################
# DATA
##################################################################################

# ami?

##################################################################################
# RESOURCES
##################################################################################

# INSTANCES
resource "aws_instance" "ec2_bastionhost" {
  ami                     = "${data.aws_ami.<tbd>.id}"
  instance_type           = "t2.micro"
  subnet_id               = module.network.aws_subnet.subnet1_bastionhost.id}
  vpc_security_group_ids  = [aws_security_group.<tbd>.id]
  key_name                = var.key_name
  tags                    = {Name = "ec2_bastionhost"}

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }
}

resource "aws_instance" "ec2_atlantis" {
  ami                     = "${data.aws_ami.<tbd>.id}"
  instance_type           = "t2.micro"
  subnet_id               = module.network.aws_subnet.subnet2_atlantis.id}
  vpc_security_group_ids  = [aws_security_group.<tbd>.id]
  key_name                = var.key_name
  tags                    = {Name = "ec2_atlantis"}

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }
}

##################################################################################
# OUTPUT
##################################################################################
##################################################################################
# VARIABLES in variables.tf
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "eu-west-1"
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

##################################################################################
# RESOURCES
##################################################################################

#Custom VPC
resource "aws_vpc" "AWS_101" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "AWS_101"
  }
}



#Subnets creation
resource "aws_subnet" "sn_public" {
  name = "test"
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.AWS_101.id
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = aws_subnet.sn_public.name}
}

resource "aws_subnet" "sn_private" {
  cidr_block = "10.0.11.0/24"
  vpc_id = aws_vpc.AWS_101.id
  availability_zone = var.region

  tags = {
    Name = "sn_private"
  }
}

#Internet gateway with route tables
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.AWS_101.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_route_table" "crt_internet_gateway" {
  vpc_id = aws_vpc.AWS_101.id

  tags = {
    Name = "crt_internet_gateway"
  }
}

resource "aws_route" "route_internet_gateway" {
  route_table_id = aws_route_table.crt_internet_gateway.id
  gateway_id = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rt_igw_association" {
  route_table_id = aws_route_table.crt_internet_gateway.id
  subnet_id = aws_subnet.sn_public.id

}

#BASTION HOST
resource "aws_instance" "BASTION_HOST" {
  ami = "ami-04facb3ed127a2eb6"
  instance_type = "t2.micro"
  availability_zone = "eu-west-1a"
  subnet_id = aws_subnet.sn_public.id
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh.id]
  key_name = "pg_keys_TEST"
  tags ={
    Name = "BASTION_HOST"
  }
}

#Security group allow SSH
resource "aws_security_group" "sg_allow_ssh" {
  vpc_id = aws_vpc.AWS_101.id

  ingress {
    from_port = "22"
    protocol = "tcp"
    to_port = "22"
    cidr_blocks = ["31.182.230.160/32"]

  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "sg_allow_ssh"
  }
}

#APPLICATION SERVER - non public IP
resource "aws_instance" "PRIVATE_HOST" {
  ami = "ami-04facb3ed127a2eb6"
  instance_type = "t2.micro"
  availability_zone = "eu-west-1a"
  subnet_id = aws_subnet.sn_private.id
  associate_public_ip_address = "false"
  key_name = "pg_keys_TEST"
  vpc_security_group_ids = [aws_security_group.sg_appserver_allow]
  tags ={
    Name = "PRIVATE_HOST"
  }
}
#Security group to allow connection to APP server through BASTION
resource "aws_security_group" "sg_appserver_allow" {
  vpc_id = aws_vpc.AWS_101.id
  ingress {
    from_port ="22"
    protocol = "tcp"
    to_port = "22"
    security_groups = [aws_security_group.sg_allow_ssh.id]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags ={
    Name = "sg_appserver_allow"
  }
}

#Elastic IP for NAT gateway + ngw creation
resource "aws_eip" "eip" {
  tags ={
    Name = "eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.sn_public.id
  tags = {
    Name = "nat_gateway"
  }
}

resource "aws_route_table" "crt_private" {
  vpc_id = aws_vpc.AWS_101.id
  tags ={
    Name = "crt_private"
  }
}

resource "aws_route_table_association" "rt_nat_association" {
  route_table_id = aws_route_table.crt_private.id
  subnet_id = aws_subnet.sn_private.id

}

resource "aws_route" "rt_ngw" {
  route_table_id = aws_route_table.crt_private.id
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"

}
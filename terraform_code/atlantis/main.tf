##################################################################################
# VARIABLES in variables.tf
##################################################################################

variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "private_key_path" {
}
variable "key_name" {
}

##################################################################################
# PROVIDERS
##################################################################################

variable "region" {
  default = "eu-west-1"
}
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

##################################################################################
# MODULES
##################################################################################

module "network" {
  source                = "./modules/network"
  network_address_space = "10.0.0.0/16"
  subnet_one_address_space = "10.0.1.0/24"
  subnet_two_address_space = "10.0.2.0/24"
}

module "instances" {
  source = "./modules/instances"
  instance_type = "t2.micro"
  ami_instance = "ami-04facb3ed127a2eb6"
  key_name = var.key_name
  av_zone = "eu-west-1a"
  atlantis_subnet = module.network.aws_private_subnet
  atlantis_subnet_id = module.network.aws_private_subnet_id
  bastion_host_subnet = module.network.aws_public_subnet
  bastion_host_subnet_id = module.network.aws_public_subnet_id
  sg_atlantis_id = module.security_group.security_group_atlantis_instance_allow_ssh_id
  sg_bastion_host_id = module.security_group.security_group_allow_ssh
}

module "security_group" {
  source = "./modules/security_groups"
  vpc_id = module.network.aws_vpc_id
}

module "routing" {
  source = "./modules/routing"
  vpc_id = module.network.aws_vpc_id
  igw_id = module.network.aws_igw_id
  nat_gw_id = module.network.aws_nat_gw_id
  public_subnet_id = module.network.aws_public_subnet_id
  private_subnet_id = module.network.aws_private_subnet_id
}



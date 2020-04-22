##################################################################################
# VARIABLES in variables.tf
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}

##################################################################################
# PROVIDERS
##################################################################################

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
  subnet1_address_space = "10.0.1.0/24"
  subnet2_address_space = "10.0.2.0/24"
  region                = "eu-west-1"
}
module "instances" {
  source = "./modules/instances"
}
module "security_group" {
  source = "modules/security_groups"
}

module "routing" {
  source = "modules/routing"
}


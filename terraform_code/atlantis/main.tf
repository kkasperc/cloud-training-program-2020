##################################################################################
# VARIABLES in variables.tf
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}


##################################################################################
# GLOBAL VARIABLES
##################################################################################

variable "network_address_space" {
  default = "10.0.0.0/16"
}
variable "subnet1_address_space" {
  default = "10.0.1.0/24"
}
variable "subnet2_address_space" {
  default = "10.0.2.0/24"
}
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
# MODULES
##################################################################################

module "network" {
  source = "modules/network" 
}
module "instances" {
  source = "modules/instances"
}
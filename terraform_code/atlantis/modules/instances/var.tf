variable "ami_instance" {
  type = string
}

variable "instance_type" {}

variable "av_zone" {}

variable "key_name" {}

variable "bastion_host_subnet" {}
variable "bastion_host_subnet_id" {}
variable "atlantis_subnet" {}
variable "atlantis_subnet_id" {}
variable "sg_bastion_host_id" {}
variable "sg_atlantis_id" {}
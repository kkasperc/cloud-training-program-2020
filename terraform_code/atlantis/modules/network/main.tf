data "aws_availability_zones" "available" {}

# NETWORKING
resource "aws_vpc" "vpc_atlantis" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = "true"
  tags                 = {Name = "vpc_atlantis"}
}
#subnet 1 is public
resource "aws_subnet" "subnet_public_bastionhost" {
  cidr_block              = var.subnet_one_address_space
  vpc_id                  = aws_vpc.vpc_atlantis.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = {Name = "subnet1_bastionhost"}
}
# subnet 2 is private
resource "aws_subnet" "subnet_private_atlantis" {
  cidr_block              = var.subnet_two_address_space
  vpc_id                  = aws_vpc.vpc_atlantis.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = {Name = "subnet2_atlantis"}
}

resource "aws_internet_gateway" "igw_atlantis" {
  vpc_id = aws_vpc.vpc_atlantis.id
  tags   = {Name = "igw_atlantis"}
}

resource "aws_eip" "eip_atlantis" {
  vpc  = true
  tags = {Name = "eip_atlantis"}
}

resource "aws_nat_gateway" "ngw_atlantis" {
  allocation_id = aws_eip.eip_atlantis.id
  subnet_id     = aws_subnet.subnet_public_bastionhost.id
  tags          = {Name = "ngw_atlantis"}
}
data "aws_route53_zone""awisysZone"{
  name = "aws.awisys.eu."
  private_zone = false
}

resource "aws_route53_record" "Atlantis-A_" {
  name = "atlantisserver.aws.awisys.eu."
  type = "A"
  ttl = "300"
  records = [aws_eip.eip_atlantis.public_ip]
  zone_id = data.aws_route53_zone.awisysZone.id
}

resource "aws_route53_record" "Atlantis-CNAME" {
  name = "atlantis.aws.awisys.eu."
  type = "CNAME"
  ttl = "300"
  records = ["AtlantisServer.aws.awisys.eu"]
  zone_id = data.aws_route53_zone.awisysZone.id
}
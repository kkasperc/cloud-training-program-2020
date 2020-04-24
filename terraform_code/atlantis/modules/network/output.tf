output "aws_vpc_name" {
  value = aws_vpc.vpc_atlantis
}

output "aws_vpc_id" {
  value = aws_vpc.vpc_atlantis.id
}

output "aws_public_subnet" {
  value = aws_subnet.subnet_public_bastionhost
}
output "aws_public1_subnet" {
  value = aws_subnet.subnet_public1_bastionhost
}
output "aws_public1_subnet_id" {
  value = aws_subnet.subnet_public1_bastionhost.id
}

output "aws_public_subnet_id" {
  value = aws_subnet.subnet_public_bastionhost.id
}

output "aws_private_subnet" {
  value = aws_subnet.subnet_private_atlantis
}

output "aws_private_subnet_id" {
  value = aws_subnet.subnet_private_atlantis.id
}

output "aws_nat_gw_id" {
  value = aws_nat_gateway.ngw_atlantis.id
}

output "aws_igw_id"{
  value = aws_internet_gateway.igw_atlantis.id
}
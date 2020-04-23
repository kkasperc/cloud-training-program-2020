output "aws_vpc_name" {
  value = aws_vpc.vpc_atlantis.name
}
output "aws_vpc_id" {
  value = aws_vpc.vpc_atlantis.id
}

output "aws_subnet_name" {
  value = aws_subnet.subnet1_bastionhost.name
}
output "aws_subnet_id" {
  value = aws_subnet.subnet1_bastionhost.id
}

output "aws_subnet_name" {
  value = aws_subnet.subnet2_atlantis.name
}
output "aws_subnet_id" {
  value = aws_subnet.subnet2_atlantis.id
}

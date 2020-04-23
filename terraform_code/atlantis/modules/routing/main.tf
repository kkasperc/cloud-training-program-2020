#NAT
resource "aws_route_table" "crt_private" {
  vpc_id = var.vpc_id
  tags ={
    Name = "crt_private"
  }
}

resource "aws_route_table_association" "rt_nat_association" {
  route_table_id = aws_route_table.crt_private.id
  subnet_id = var.private_subnet_id
}

resource "aws_route" "rt_ngw" {
  route_table_id = aws_route_table.crt_private.id
  nat_gateway_id = var.nat_gw_id
  destination_cidr_block = "0.0.0.0/0"

}

#GW
resource "aws_route_table" "crt_internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "crt_internet_gateway"
  }
}

resource "aws_route" "route_internet_gateway" {
  route_table_id = aws_route_table.crt_internet_gateway.id
  gateway_id = var.igw_id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rt_igw_association" {
  route_table_id = aws_route_table.crt_internet_gateway.id
  subnet_id = var.public_subnet_id

}
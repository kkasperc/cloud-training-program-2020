
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
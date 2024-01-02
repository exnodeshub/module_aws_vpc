# Elastic IP
resource "aws_eip" "general-elastic-ip-for-nat-gw" {
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.general-igw]
}

# NAT gateway
resource "aws_nat_gateway" "general-nat-gw" {
  allocation_id = aws_eip.general-elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.general-public-subnet-1.id
  depends_on    = [aws_eip.general-elastic-ip-for-nat-gw]
}

resource "aws_route" "general-nat-gw-route" {
  route_table_id         = aws_route_table.general-private-route-table.id
  nat_gateway_id         = aws_nat_gateway.general-nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "general-igw" {
  vpc_id = aws_vpc.general-vpc.id
}

# Route the public subnet traffic through the Internet Gateway
resource "aws_route" "general-public-internet-igw-route" {
  route_table_id         = aws_route_table.general-public-route-table.id
  gateway_id             = aws_internet_gateway.general-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

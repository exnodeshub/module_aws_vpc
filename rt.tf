# Route tables for the subnets
resource "aws_route_table" "general-public-route-table" {
  vpc_id = aws_vpc.general-vpc.id
  tags = {
    Name = "Public Route Table"
  }
}
resource "aws_route_table" "general-private-route-table" {
  vpc_id = aws_vpc.general-vpc.id
  tags = {
    Name = "Private Route Table"
  }
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "general-public-route-1-association" {
  route_table_id = aws_route_table.general-public-route-table.id
  subnet_id      = aws_subnet.general-public-subnet-1.id
}
resource "aws_route_table_association" "general-public-route-2-association" {
  route_table_id = aws_route_table.general-public-route-table.id
  subnet_id      = aws_subnet.general-public-subnet-2.id
}
resource "aws_route_table_association" "general-private-route-1-association" {
  route_table_id = aws_route_table.general-private-route-table.id
  subnet_id      = aws_subnet.general-private-subnet-1.id
}
resource "aws_route_table_association" "general-private-route-2-association" {
  route_table_id = aws_route_table.general-private-route-table.id
  subnet_id      = aws_subnet.general-private-subnet-2.id
}

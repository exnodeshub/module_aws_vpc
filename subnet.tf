# Public subnets
resource "aws_subnet" "general-public-subnet-1" {
  cidr_block        = var.general_public_subnet_1_cidr
  vpc_id            = aws_vpc.general-vpc.id
  availability_zone = var.general_availability_zones[0]
  tags = {
    Name = "Public Subnet 1"
  }
}
resource "aws_subnet" "general-public-subnet-2" {
  cidr_block        = var.general_public_subnet_2_cidr
  vpc_id            = aws_vpc.general-vpc.id
  availability_zone = var.general_availability_zones[1]
  tags = {
    Name = "Public Subnet 2"
  }
}

# Private subnets
resource "aws_subnet" "general-private-subnet-1" {
  cidr_block        = var.general_private_subnet_1_cidr
  vpc_id            = aws_vpc.general-vpc.id
  availability_zone = var.general_availability_zones[0]
  tags = {
    Name = "Private Subnet 1"
  }
}
resource "aws_subnet" "general-private-subnet-2" {
  cidr_block        = var.general_private_subnet_2_cidr
  vpc_id            = aws_vpc.general-vpc.id
  availability_zone = var.general_availability_zones[1]
  tags = {
    Name = "Private Subnet 2"
  }
}
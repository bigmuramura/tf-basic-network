# vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true # AWSのDNSサーバで名前解決有効
  enable_dns_hostnames = true # VPC内のリソースにパブリックDNSホスト名を自動割り当て有効
  tags = {
    Name = format("%s-vpc", var.project_name)
  }
}

# Public Subnet
## Public Subnet 1
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public1_cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
  tags = {
    Name = format("%s-public-1a", var.project_name)
  }
}
## Public Subnet 2
resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public2_cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
  tags = {
    Name = format("%s-public-1c", var.project_name)
  }
}

## Private Subnet 1
resource "aws_subnet" "private-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private1_cidr
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"
  tags = {
    Name = format("%s-private-1a", var.project_name)
  }
}
## Private Subnet 2
resource "aws_subnet" "private-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private2_cidr
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"
  tags = {
    Name = format("%s-private-1c", var.project_name)
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-igw", var.project_name)
  }
}

# Route Table
## Public
resource "aws_route_table" "public-1" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-%s-public-rt-1", var.env, var.project_name)
  }
}
## Private
resource "aws_route_table" "private-1" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-private-rt-1a", var.project_name)
  }
}

# Routing
## Public
resource "aws_route" "public-1" {
  route_table_id         = aws_route_table.public-1.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Association to Public Route Table
## Public
resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-1.id
}
resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-1.id
}

## Private
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-1.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private-1.id
}

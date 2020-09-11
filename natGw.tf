# NAT Gateway
resource "aws_eip" "nat-gateway-eip-1" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat-gateway-eip-2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

# NATゲートウェイ作成
resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.nat-gateway-eip-1.id
  subnet_id     = aws_subnet.public-1.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = format("%s-natgw-1a", var.project_name)
  }
}
resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id = aws_eip.nat-gateway-eip-2.id
  subnet_id     = aws_subnet.public-2.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = format("%s-natgw-1c", var.project_name)
  }
}

# Route Table
resource "aws_route_table" "private-2" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-private-rt-1c", var.project_name)
  }
}

# Routing
resource "aws_route" "pribate-1" {
  route_table_id         = aws_route_table.private-1.id
  nat_gateway_id         = aws_nat_gateway.nat-gateway-1.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private-2" {
  route_table_id         = aws_route_table.private-2.id
  nat_gateway_id         = aws_nat_gateway.nat-gateway-2.id
  destination_cidr_block = "0.0.0.0/0"
}

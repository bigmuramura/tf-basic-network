resource "aws_security_group" "public_sg" {
  name   = format("%s-public-sg", var.project_name)
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "My Home"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["115.179.182.204/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-public-sg", var.project_name)
  }
}

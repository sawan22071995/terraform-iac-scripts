# Create NAT gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags          = var.aws_tags
}

# Create elastic IP for NAT gateway
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = var.aws_tags
}
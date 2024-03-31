#find the availablity zone in region
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = var.aws_vpc_cidr
  tags       = var.aws_tags
}

# Create the public subnets
resource "aws_subnet" "public_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.aws_vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index] # Mumbai availability zones
  map_public_ip_on_launch = true                                                     # Assign public IP addresses to instances in public subnets
  tags                    = var.aws_tags
}

# Create the private subnets
resource "aws_subnet" "private_subnets" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.aws_vpc_cidr, 8, count.index + 2)         # Calculate CIDR block based on VPC CIDR and subnet mask
  availability_zone = data.aws_availability_zones.available.names[count.index] # Mumbai availability zones
  tags              = var.aws_tags
}

# Create the internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = var.aws_tags
}

# Create the public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = var.aws_tags
}

# Create the private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  tags = var.aws_tags
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "public_subnet_associations" {
  count          = 2
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "private_subnet_associations" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}


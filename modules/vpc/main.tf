# modules/vpc/main.tf

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Main VPC"
  }
}

# Example of creating multiple subnets
resource "aws_subnet" "public_subnet" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Public Subnet ${count.index}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "rta" {
  count          = length(aws_subnet.public_subnet.*.id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.rt.id
}

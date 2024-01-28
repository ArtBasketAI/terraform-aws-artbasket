resource "aws_vpc" "artbasket_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ArtbasketVPC"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.artbasket_vpc.id
  cidr_block        = var.subnet_a_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.artbasket_vpc.id
  cidr_block        = var.subnet_b_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.artbasket_vpc.id
}

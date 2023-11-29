# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc.cidr_block_vpc
  enable_dns_hostnames = var.vpc.enable_dns_hostnames

  tags = {
    Environment = var.vpc.env
  }
}

# Create subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.vpc.public_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.vpc.public_subnets, count.index)
  availability_zone = element(var.vpc.availability_zones, count.index)
  tags = {
    Environment = var.vpc.env
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.vpc.private_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.vpc.private_subnets, count.index)
  availability_zone = element(var.vpc.availability_zones, count.index)
  tags = {
    Environment = var.vpc.env
  }
}

# Create internet gateway 
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Environment = var.vpc.env
  }
}

# Create eip
resource "aws_eip" "nat_ip" {
  vpc = var.vpc.nat_eip
  tags = {
    Environment = var.vpc.env
  }
}

# Create nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnets[var.vpc.nat_subnet].id
  tags = {
    Environment = var.vpc.env
  }
}

# Create route table 
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc.cidr_block_route
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Environment = var.vpc.env
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc.cidr_block_route
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Environment = var.vpc.env
  }
}

# Associate route table 
resource "aws_route_table_association" "public_route_associate" {
  for_each       = { for k, v in aws_subnet.public_subnets : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_route_associate" {
  for_each       = { for k, v in aws_subnet.private_subnets : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route.id
}

# Security group
resource "aws_security_group" "sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = var.sg.name
  description = var.sg.description

  dynamic "ingress" {
    for_each = var.sg.ingress
    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.sg.egress
    content {
      protocol    = egress.value.protocol
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = var.sg.env
  }
}
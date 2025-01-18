# Create a aws resource group for VPC
resource "aws_vpc" "base" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "web server"
  }

}

# Create a aws internet gateway resource
resource "aws_internet_gateway" "base" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "${var.network_name}-igw"
  }
  depends_on = [aws_vpc.base]
}

# Create a aws private route table network resource
resource "aws_route_table" "private" {
  count  = local.private_subnet_count != 0 ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "${var.network_name}-private"
  }
  depends_on = [aws_vpc.base]
}

# Create a aws public route table network resource and add route in public route table to internet gateway
resource "aws_route_table" "public" {
  count  = local.public_subnet_count != 0 ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "${var.network_name}-public"
  }
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.base.id
  }
  depends_on = [aws_vpc.base, aws_internet_gateway.base]
}

# Create subnets resource for public
resource "aws_subnet" "public" {
  count             = local.public_subnet_count
  vpc_id            = aws_vpc.base.id
  availability_zone = var.subnets_public[count.index].az
  cidr_block        = var.subnets_public[count.index].cidr
  tags = {
    Name = var.subnets_public[count.index].name
  }
}

# public subnet resource associate with public route table
resource "aws_route_table_association" "public" {
  count          = length(var.subnets_public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id

}

# Create subnets resource for private  
resource "aws_subnet" "private" {
  count             = local.private_subnet_count
  vpc_id            = aws_vpc.base.id
  availability_zone = element(var.subnets_private, count.index).az
  cidr_block        = var.subnets_private[count.index].cidr
  tags = {
    Name = var.subnets_private[count.index].name
  }
}

# private subnet resource associate with public route table 
resource "aws_route_table_association" "private" {
  count          = length(var.subnets_private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id

}

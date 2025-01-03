# create a aws dev net subnet group 1
resource "aws_subnet" "dev1" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.0.0/24"
  tags = {
    Name = "dev-1"
  }

}

# create a aws dev net subnet group 2
resource "aws_subnet" "dev2" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1b"
  cidr_block        = "192.168.1.0/24"
  tags = {
    Name = "dev-2"
  }

}

# create a aws web net subnet group 3
resource "aws_subnet" "web1" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.2.0/24"
  tags = {
    Name = "web-1"
  }
}

# create a aws web net subnet group 4
resource "aws_subnet" "web2" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1b"
  cidr_block        = "192.168.3.0/24"
  tags = {
    Name = "web-2"
  }
}

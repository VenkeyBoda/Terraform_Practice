# create a aws dev net subnet group 1
resource "aws_subnet" "dev1" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.0.0/24"
  tags = {
    Name = "dev-1"
  }
  depends_on = [aws_vpc.net]
}

# create a aws dev net subnet group 2
resource "aws_subnet" "dev2" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1b"
  cidr_block        = "192.168.1.0/24"
  tags = {
    Name = "dev-2"
  }
  depends_on = [aws_vpc.net]
}

# create a aws web net subnet group 3
resource "aws_subnet" "web1" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.2.0/24"
  tags = {
    Name = "web-1"
  }
  depends_on = [aws_vpc.net]
}

# create a aws web net subnet group 4
resource "aws_subnet" "web2" {
  vpc_id            = aws_vpc.net.id
  availability_zone = "ap-south-1b"
  cidr_block        = "192.168.3.0/24"
  tags = {
    Name = "web-2"
  }
  depends_on = [aws_vpc.net]
}

# create a aws test cloud subnet group 1
resource "aws_subnet" "test1" {
  vpc_id            = aws_vpc.cloud.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "test-1"
  }
  depends_on = [aws_vpc.cloud]
}

# create a aws test cloud subnet group 2
resource "aws_subnet" "test2" {
  vpc_id            = aws_vpc.cloud.id
  availability_zone = "ap-south-1b"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "test-2"
  }
  depends_on = [aws_vpc.cloud]
}

# create a aws app cloud subnet group 3
resource "aws_subnet" "app1" {
  vpc_id            = aws_vpc.cloud.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "app-1"
  }
  depends_on = [aws_vpc.cloud]
}

# create a aws app cloud subnet group 4
resource "aws_subnet" "app2" {
  vpc_id            = aws_vpc.cloud.id
  availability_zone = "ap-south-1b"
  cidr_block        = "10.0.4.0/24"
  tags = {
    Name = "app-2"
  }
  depends_on = [aws_vpc.cloud]
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Venkat_BB"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "public_rta" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public.id
}


resource "aws_security_group" "ec2_sg" {
  name       = "allow_ssh"
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "my-key"
  public_key = file(pathexpand(var.public_key_path))
}

# using data sources for executing the results
data "aws_ami" "webimage" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.web_instance_info.filter_ami.name]
  }
  owners = [var.web_instance_info.filter_ami.owner] # Canonical
}

# create an ec2 instance resource with ubuntu 24.04
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.webimage.id
  instance_type               = var.web_instance_info.instance_type
  key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = var.web_instance_info.associate_public_ip_address
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "Venkat_EC2"
  }
}


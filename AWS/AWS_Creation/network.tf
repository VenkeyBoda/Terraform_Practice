# create a aws 4 subnets groups using count
resource "aws_subnet" "subnets" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.network.id
  availability_zone = var.subnet_azs[count.index]
  cidr_block        = var.subnet_cidrs[count.index]
  depends_on        = [aws_vpc.network]
  tags = {
    Name = var.subnet_names[count.index]
  }

}



# create a aws subnet group
# resource "aws_subnet" "web1" {
#   vpc_id            = aws_vpc.network.id
#   availability_zone = var.subnet_azs[0]
#   cidr_block        = var.subnet_cidrs[0]
#   tags = {
#     Name = var.subnet_names[0]
#   }
#   depends_on = [aws_vpc.network]
# }

# # create a aws subnet group 2
# resource "aws_subnet" "web2" {
#   vpc_id            = aws_vpc.network.id
#   availability_zone = var.subnet_azs[1]
#   cidr_block        = var.subnet_cidrs[1]
#   tags = {
#     Name = var.subnet_names[1]
#   }
#   depends_on = [aws_vpc.network]
# }

# # create a aws subnet group 3
# resource "aws_subnet" "app1" {
#   vpc_id            = aws_vpc.network.id
#   availability_zone = var.subnet_azs[2]
#   cidr_block        = var.subnet_cidrs[2]
#   tags = {
#     Name = var.subnet_names[2]
#   }
#   depends_on = [aws_vpc.network]
# }

# # create a aws subnet group 4
# resource "aws_subnet" "app2" {
#   vpc_id            = aws_vpc.network.id
#   availability_zone = var.subnet_azs[3]
#   cidr_block        = var.subnet_cidrs[3]
#   tags = {
#     Name = var.subnet_names[3]
#   }
#   depends_on = [aws_vpc.network]
# }


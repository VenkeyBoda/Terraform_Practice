# create a resource group

resource "aws_vpc" "network" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "test-tf"
  }

}
## I want to create a vpc with 4 subnets in AWS

# Create a aws resource group (network)
resource "aws_vpc" "net" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "test_tf"
  }
}

#create a aws resource another group (cloud)
resource "aws_vpc" "cloud" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "deploy_tf"
  }
}

## I want to create a vpc with 4 subnets in AWS

# Aws Provider source and version being used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

# Configure the aws Azure Provider
provider "aws" {
  region = "ap-south-1"
}

# Create a aws resource group
resource "aws_vpc" "net" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "build_tf"
  }
}

resource "aws_vpc" "net2" {
  cidr_block = "192.168.10.0/24"
  tags = {
    Name = "test_terraform"
  }
}

resource "aws_vpc" "net3" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "deploy_tf"
  }
}
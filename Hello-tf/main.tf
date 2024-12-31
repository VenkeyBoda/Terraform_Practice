
# Aws Provider source and version being used
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }

# Azure Provider source and version being used    
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}

# Configure the aws Azure Provider
provider "aws" {
  region = "ap-south-1"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
    subscription_id = "378c0d57-dbfd-4234-a90e-e479534fd83d"
}

# Create a aws resource group
resource "aws_vpc" "net" {
    cidr_block = "10.10.0.0/16"
    tags = {
      Name = "Hello-terraform"
    }

}

# Create a azure resource group
resource "azurerm_resource_group" "net" {
  name     = "Hello-terraform"
  location = "East US"
}

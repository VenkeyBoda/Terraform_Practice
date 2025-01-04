# Azure Provider source and version being used   
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {   
    }
    subscription_id = "378c0d57-dbfd-4234-a90e-e479534fd83d"
}

# Create a azure resource group
resource "azurerm_resource_group" "net" {
  name     = "Hello-terraform"
  location = "East US"
}

# Create a azure resource group
resource "azurerm_resource_group" "base" {
  name     = "build"
  location = "East US"

}

# Create a azure virtual network
resource "azurerm_virtual_network" "ntier" {
  name                = "ntier"
  resource_group_name = azurerm_resource_group.base.name
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  depends_on          = [azurerm_resource_group.base]

}

# Create a azure subnet web group 1
resource "azurerm_subnet" "web" {
  name                 = "web"
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.ntier.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [
    azurerm_resource_group.base,
    azurerm_virtual_network.ntier
  ]

}

# Create a azure subnet app group 2
resource "azurerm_subnet" "app" {
  name                 = "app"
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.ntier.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_resource_group.base,
    azurerm_virtual_network.ntier
  ]

}

# Create a zure subnet db group 3
resource "azurerm_subnet" "db" {
  name                 = "db"
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.ntier.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_resource_group.base,
    azurerm_virtual_network.ntier
  ]

}

# Create a azure resource group
resource "azurerm_resource_group" "base" {
  name     = "RG_Main"
  location = "eastus"

}

# Create a azure virtual network group
resource "azurerm_virtual_network" "ntier" {
  name                = "ntier_group"
  resource_group_name = azurerm_resource_group.base.name
  address_space       = ["10.0.0.0/16"]
  location            = "esatus"
  depends_on          = [azurerm_resource_group.base]

}

# Create a azure subnet group
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

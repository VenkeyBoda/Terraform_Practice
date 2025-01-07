# Create a azure resource group
resource "azurerm_resource_group" "base" {
  name     = var.location_info[0].name
  location = var.location_info[0].location

}

# Create a azure virtual network group
resource "azurerm_virtual_network" "ntier" {
  count               = local.virtual_netwok_count
  name                = var.virtual_network_info[count.index].name
  resource_group_name = azurerm_resource_group.base.name
  address_space       = [var.virtual_network_info[count.index].address_space]
  location            = var.virtual_network_info[count.index].location
  depends_on          = [azurerm_resource_group.base]

}

# Create a azure subnet group
resource "azurerm_subnet" "web" {
  count                = local.subnets_count
  name                 = var.subnets_info[count.index].name
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.ntier[0].name
  address_prefixes     = [var.subnets_info[count.index].address_prefix]
  depends_on = [
    azurerm_resource_group.base,
    azurerm_virtual_network.ntier
  ]

}


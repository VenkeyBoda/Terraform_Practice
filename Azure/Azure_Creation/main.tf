# Create a azure resource group
resource "azurerm_resource_group" "base" {
  name     = var.purpose
  location = var.location_info

}

# Create a azure virtual network group
resource "azurerm_virtual_network" "ntier" {
  count               = local.virtual_netwok_count
  name                = "${var.purpose}-vnet"
  resource_group_name = azurerm_resource_group.base.name
  address_space       = var.virtual_network_info[0].address_space
  location            = var.location_info
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

# create a public ip address
resource "azurerm_public_ip" "base" {
  name                = "${var.purpose}-ip"
  location            = var.location_info
  resource_group_name = azurerm_resource_group.base.name
  allocation_method   = "Static"
  depends_on          = [azurerm_resource_group.base]
}

# ctreate a network interface
resource "azurerm_network_interface" "web" {
  name                = "web-nic"
  location            = var.location_info
  resource_group_name = azurerm_resource_group.base.name
  ip_configuration {
    name                          = "web"
    subnet_id                     = azurerm_subnet.web[var.webserver_subnet_value].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.base.id
  }
  depends_on = [azurerm_subnet.web,
  azurerm_public_ip.base]
}

# create a network interface security group association
resource "azurerm_network_interface_security_group_association" "nsg_to_nic" {
  network_interface_id      = azurerm_network_interface.web.id
  network_security_group_id = azurerm_network_security_group.web.id

}
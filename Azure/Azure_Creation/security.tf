# create a network security group
resource "azurerm_network_security_group" "web" {
  resource_group_name = azurerm_resource_group.base.name
  name                = "webnsg"
  location            = "centralindia"

}

resource "azurerm_network_security_rule" "rules" {
  name                        = "openssh"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.base.name
  network_security_group_name = azurerm_network_security_group.web.name

}

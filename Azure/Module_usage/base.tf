resource "azurerm_resource_group" "base" {
  name     = "azure_modules"
  location = "centralindia"
}

# create a virtual network module
module "vnet" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/vnet?ref=v1.0.0"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  network_info = {
    address_space = ["10.0.0.0/16"]
    name          = "ntier"
    subnets = {
      web = "10.0.0.0/24"
      app = "10.0.1.0/24"
      db  = "10.0.2.0/24"
    }
  }
  tags = {
    Env  = "Dev"
    Team = "DevOps"
  }
  depends_on = [azurerm_resource_group.base]
}

# create a network security group module
module "nsg" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/security-group?ref=v1.0.1"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  nsg_info = {
    name = "web-nsg"
    security_rules = [{
      name                   = "openssh"
      priority               = 1000
      direction              = "Inbound"
      protocal               = "Tcp"
      destination_port_range = 22
      access                 = "Allow"
      }, {
      name                   = "openhttp"
      priority               = 1010
      direction              = "Inbound"
      protocal               = "Tcp"
      destination_port_range = 80
      access                 = "Allow"
    }]
  }
  tags = {
    Env  = "qa"
    Team = "DevOps"
  }
  depends_on = [azurerm_resource_group.base]
}

# create a public ip address module
module "pip_address" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/Public_ip?ref=v1.0.2"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  pip_address = {
    name              = "web-pip"
    allocation_method = "Static"
  }
  tags = {
    Env  = "qa"
    Team = "DevOps"
  }
  depends_on = [azurerm_resource_group.base]

}

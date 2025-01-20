resource "azurerm_resource_group" "base" {
  name     = "azure_modules"
  location = "centralindia"
}

# create a virtual network module
module "vnet" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/vnet"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  network_info = {
    address_space = ["10.0.0.0/16"]
    name          = "ntier"
  }
  tags = {
    Env  = "Dev"
    Team = "DevOps"
  }
  depends_on = [azurerm_resource_group.base]
}

# Create a subnets module
module "subnets" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/subnets"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  vnet_name      = module.vnet.vnet_name
  subnets_info = [{
    name             = "web"
    address_prefixes = "10.0.0.0/24"
    }, {
    name             = "app"
    address_prefixes = "10.0.1.0/24"
    }, {
    name             = "db"
    address_prefixes = "10.0.2.0/24"
  }]
}
# create a network security group module
module "nsg" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/security-group"
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
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/Public_ip"
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

# Create a network interface and network interface security group association
module "nic_to_nsg" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/Network_interface"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  nsg-id         = module.nsg.nsg_id
  subnets_id     = module.subnets.subnets_id[0]
  pip-id         = module.pip_address.pip_id
  tags = {
    Env  = "dev"
    Team = "DevOps"
  }
  depends_on = [module.subnets.subnets_id,
  module.pip_address.pip_id]

}

# create a vm with a network interface associated with nsg and public ip
module "virtual_machine" {
  source         = "github.com/VenkeyBoda/Modules_TF//Azure/Virtual_Machine"
  resource_group = azurerm_resource_group.base.name
  location       = azurerm_resource_group.base.location
  nic_id         = module.nic_to_nsg.nic_id
  web_server_info = {
    name = "web-VM"
  }
  depends_on = [module.nic_to_nsg.nic_id,
    module.nsg.nsg_id,
    module.subnets.subnet_id,
  module.pip_address.pip_id]
}

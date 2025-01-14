location_info = "centralindia"

purpose = "ntier"

# virtual network variables configuration
virtual_network_info = [{
  location      = "centralindia"
  address_space = ["10.0.0.0/16"]

}]

# subnets variables configuration
subnets_info = [{
  name           = "web-1"
  address_prefix = "10.0.0.0/24"
  }, {
  name           = "app-1"
  address_prefix = "10.0.1.0/24"
  }, {
  name           = "db-1"
  address_prefix = "10.0.2.0/24"
}]

# nsg variables configuration
nsg_info = {
  name = "webnsg"
  security_rules = [{
    name                   = "openssh"
    priority               = 1000
    destination_port_range = 22
    access                 = "Allow"
    }, {
    name                   = "openhttp"
    priority               = 1010
    destination_port_range = 80
    access                 = "Allow"
  }]
}

webserver_subnet_value = 0

web_server_info = {
  name = "webserver"
}
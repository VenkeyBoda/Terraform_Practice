# Azure Region Configuration
location_info = [{

}]

# virtual network variables configuration
virtual_network_info = [{
  location      = "centralindia"
  address_space = "10.0.0.0/16"

}]

# subnets variables configuration
subnets_info = [{
  name           = "web-1"
  address_prefix = "10.0.0.0/24"
  }, {
  name           = "web-2"
  address_prefix = "10.0.1.0/24"
  }, {
  name           = "app-1"
  address_prefix = "10.0.2.0/24"
  }, {
  name           = "app-2"
  address_prefix = "10.0.3.0/24"
}]

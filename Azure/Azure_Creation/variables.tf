# create a variable group for resourse group
variable "location_info" {
  type = list(object({
    name     = optional(string, "web-server")
    location = optional(string, "eastus")
  }))
  description = "variable for a resource group"
}

# create a variable group for virtual network
variable "virtual_network_info" {
  type = list(object({
    name          = optional(string, "ntier_group")
    address_space = string
    location      = string

  }))
}

# create a variable group for subnets 
variable "subnets_info" {
  type = list(object({
    name           = string
    address_prefix = string
  }))

}

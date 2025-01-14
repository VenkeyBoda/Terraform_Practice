
variable "purpose" {
  type        = string
  description = "purpose of the resource group"
  default     = "ntier"
}
# create a variable group for resourse group
variable "location_info" {
  type        = string
  description = "variable for a resource group"
  default     = "centralindia"
}

# create a variable group for virtual network
variable "virtual_network_info" {
  type = list(object({
    address_space = list(string)

  }))
}

# create a variable group for subnets 
variable "subnets_info" {
  type = list(object({
    name           = string
    address_prefix = string
  }))

}

# create a variable group form network security group
variable "nsg_info" {
  type = object({
    name = optional(string, "web-nsg")
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = optional(string, "Inbound")
      access                     = optional(string, "Deny")
      protocol                   = optional(string, "Tcp")
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")

    }))
  })
}

variable "webserver_subnet_value" {
  description = "Index of the subnet to use"
  type        = number
  default     = 0
}
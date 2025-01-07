# create a variable group for region this is used (provider.tf)
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "variable for a region in aws"

}

# create a variable group for cidr range this is used (main.tf)
variable "vpc_cidr" {
  type        = string
  default     = "192.168.0.0/16"
  description = "variable for a network range"

}

# create a variable group for subnets cidr range this is used (network.tf)
variable "subnets_info" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))

  default = [{
    name = "web-1"
    cidr = "192.168.0.0/24"
    az   = "ap-south-1a"
  }]
  description = "variable for a subnet network ranges"
}

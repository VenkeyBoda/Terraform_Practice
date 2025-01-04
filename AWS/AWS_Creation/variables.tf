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
variable "subnet_cidrs" {
  type = list(string)
  default = [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24",
    "192.168.3.0/24"
  ]
  description = "variable for a subnet network ranges"
}

# create a variable group for subnets availability zones this is used (network.tf)
variable "subnet_azs" {
  type = list(string)
  default = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1a",
    "ap-south-1b"
  ]
  description = "variables for a availability zones"
}

# create a variable group for subnets tags name this is used (network.tf)
variable "subnet_names" {
  type = list(string)
  default = [
    "web-1",
    "web-2",
    "app-1",
    "app-2"
  ]

}

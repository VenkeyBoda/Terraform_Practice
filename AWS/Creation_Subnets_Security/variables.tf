# Create a varibale group for vpc region
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "variable for a region in aws"
}

# create a variable group for cidr range
variable "vpc_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "variable for a network range"
}

# create a variable for network name
variable "network_name" {
  type        = string
  default     = "ntier"
  description = "variable for network default name"
}

# create a variable group for public subnets
variable "subnets_public" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "public subnets"
}

# create a variable group for private subnets
variable "subnets_private" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "private subnets"
}

# create a variable group for web security group
variable "web_security_group" {
  type = object({
    name        = optional(string, "web-sg")
    description = optional(string, "Allow inbound traffic and all outbound traffic")
    rules = list(object({
      cidr_ipv4   = optional(string, "0.0.0.0/0")
      from_port   = number
      to_port     = number
      ip_protocol = optional(string, "tcp")
      }
    ))
  })
}

# create a variable group for db security group
variable "db_security_group" {
  type = object({
    name        = optional(string, "db-sg")
    description = optional(string, "Allow inbound traffic and all outbound traffic")
    rules = list(object({
      cidr_ipv4   = optional(string, "0.0.0.0/0")
      from_port   = number
      to_port     = number
      ip_protocol = optional(string, "tcp")
      }
    ))
  })
}

# variable group for importing an existing key pair the public key
variable "key-info" {
  type = object({
    name            = string
    public_key_path = optional(string, "~/.ssh/id_rsa.pub")
  })
}
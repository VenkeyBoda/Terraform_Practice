# AWS Region Variable
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "variable for a region in aws"
}

# VPC CIDR Range Variable
variable "vpc_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "variable for a network range"
}

# Network Name Variable
variable "network_name" {
  type        = string
  default     = "ntier"
  description = "variable for network default name"
}

# Public Subnets Variable
variable "subnets_public" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "public subnets"
}

# Private Subnets Variable
variable "subnets_private" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "private subnets"
}

# Web Security Group Variable
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

# Database Security Group Variable
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

# # Key Pair Variable Group for importing an existing key pair the public key
variable "key-info" {
  type = object({
    name             = string
    public_key_path  = optional(string, "~/.ssh/id_rsa.pub")
    private_key_path = optional(string, "~/.ssh/id_rsa")
  })
}

# variable group information for ec2 instance with ubuntu 24.04
variable "web_instance_info" {
  type = object({
    name = string
    filter_ami = object({
      name  = optional(string, "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*")
      owner = optional(string, "099720109477")
    })
    instance_type               = optional(string, "t2.micro")
    associate_public_ip_address = optional(bool, true)
    username                    = optional(string, "ubuntu")

  })
}

variable "instance_id" {
  type    = string
  default = "2"

}
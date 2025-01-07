# AWS Region Configuration
region = "ap-south-1"

# VPC Configuration
vpc_cidr     = "172.16.0.0/16"
network_name = "ntier"

# Public Subnets Configuration
subnets_public = [{
  name = "web-1"
  cidr = "172.16.0.0/24"
  az   = "ap-south-1a"
  }, {
  name = "web-2"
  cidr = "172.16.1.0/24"
  az   = "ap-south-1b"
}]

# Private Subnets Configuration
subnets_private = [{
  name = "app-1"
  cidr = "172.16.2.0/24"
  az   = "ap-south-1a"
  }, {
  name = "app-2"
  cidr = "172.16.3.0/24"
  az   = "ap-south-1b"
}]

# ==========================
# Security Group Configurations
# ==========================

# Web Security Group
web_security_group = {
  rules = [{
    from_port = 22 # SSH access
    to_port   = 22
    }, {
    from_port = 8080 # Application access
    to_port   = 8080

  }]
}

# Database Security Group
db_security_group = {
  rules = [{
    from_port = 3306 # MySQL access
    to_port   = 3306
  }]
}

# Key Pair Configuration
key-info = {
  name = "my-key-pair" # Name of the SSH key pair for instance access
}

# Web Instance Information
web_instance_info = {
  name = "test-server" # Name of the web server instance
  filter_ami = {

  }
}

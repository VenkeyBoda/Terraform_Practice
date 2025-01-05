# using tfvars 
region = "ap-south-1"

vpc_cidr = "172.16.0.0/16"

network_name = "ntier"

subnets_public = [{
  name = "web-1"
  cidr = "172.16.0.0/24"
  az   = "ap-south-1a"
  }, {
  name = "web-2"
  cidr = "172.16.1.0/24"
  az   = "ap-south-1b"
}]

subnets_private = [{
  name = "app-1"
  cidr = "172.16.2.0/24"
  az   = "ap-south-1a"
  }, {
  name = "app-2"
  cidr = "172.16.3.0/24"
  az   = "ap-south-1b"
}]

web_security_group = [ {
  name = "web-sg"
  
} ]

# Key Pair Variable Group for importing an existing key pair the public key
variable "key-info" {
  type = object({
    name             = string
    public_key_path  = string
    private_key_path = string
  })
}

# Variable for the name of the web instance
variable "web_instance_name" {
  type = string

}

# Variable for the type of the web instance (e.g., t2.micro)
variable "web_instance_type" {
  type = string
}

# Variable to determine if the instance should associate a public IP address
variable "instance_associate_public_ip_address" {
  type = bool
  
}

# Variable for the username to be used for SSH access to the instance
variable "instance_username" {
  type = string
  
}

# Variable for filtering AMIs by name
variable "filter_ami_name" {
  type = string
  
}

# Variable for filtering AMIs by owner ID
variable "filter_ami_owner" {
  type = string
  
}

# Variable for specifying the subnet ID where the instance will be launched
variable "subnet_id" {
  type = list(string)
  
}

# Variable for specifying VPC security group IDs associated with the instance
variable "vpc_security_group_ids" {
  type = string
  
}

# # Variable for build identification, useful in CI/CD pipelines or versioning
# variable "build_id" {
#   type = string
#   default = "1"
  
# }

# # Variable for specifying a startup script to run on instance creation
# variable "script" {
#   type = string 
# }

# Variable for specifying the number of instances to create
variable "instance_count" {
  type = number
  default = 2
  
}
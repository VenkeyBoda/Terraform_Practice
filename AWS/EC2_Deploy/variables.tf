variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_key_path" {
  description = "Path to your SSH public key"
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
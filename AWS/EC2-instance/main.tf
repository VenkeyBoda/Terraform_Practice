# importing an existing key pair the public key resource
resource "aws_key_pair" "sshkey" {
  key_name   = var.key-info.name
  public_key = file(var.key-info.public_key_path)

}

# using data sources for executing the results
data "aws_ami" "webimage" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.filter_ami_name]
  }
  owners = [var.filter_ami_owner] # Canonical
}

# create an ec2 instance resource with ubuntu 24.04
resource "aws_instance" "web" {
  count                       = var.instance_count
  ami                         = data.aws_ami.webimage.id
  instance_type               = var.web_instance_type
  key_name                    = aws_key_pair.sshkey.key_name
  associate_public_ip_address = var.instance_associate_public_ip_address
  tags = {
    Name = "${var.web_instance_name}-${count.index}"
    user = var.instance_username
  }
  subnet_id              = var.subnet_id[count.index]
  vpc_security_group_ids = [var.vpc_security_group_ids]
}

# # The primary use-case for the null resource is as a do-nothing containerfor arbitrary actions taken by a provisioner
# resource "null_resource" "web_null" {
#   count = var.instance_count
#   triggers = {
#     build_id = var.build_id
#   }

# # Establishes connection to be used by all
#   connection {
#     type        = "ssh"
#     user        = var.instance_username
#     private_key = file(var.key-info.private_key_path)
#     host        = aws_instance.web[count.index].public_ip
#   }
# # generic remote provisioners (i.e. file/remote-exec)
#   provisioner "remote-exec" {
#     script = var.script
#   }

# }


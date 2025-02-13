# importing an existing key pair the public key resource
# resource "aws_key_pair" "sshkey" {
#   key_name   = var.key-info.name
#   public_key = file(var.key-info.public_key_path)

# }

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
  key_name                    = "id_rsa"
  associate_public_ip_address = var.instance_associate_public_ip_address
  tags = {
    Name = "${var.web_instance_name}-${count.index}"
    user = var.instance_username
  }
  subnet_id              = var.subnet_id[count.index]
  vpc_security_group_ids = [var.vpc_security_group_ids]
}



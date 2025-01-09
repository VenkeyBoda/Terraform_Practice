# create an ec2 instance resource with ubuntu 24.04
resource "aws_instance" "web" {
  ami                         = data.aws_ami.webimage.id
  instance_type               = var.web_instance_info.instance_type
  key_name                    = aws_key_pair.sshkey.key_name
  associate_public_ip_address = var.web_instance_info.associate_public_ip_address
  tags = {
    Name = var.web_instance_info.name
  }
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web.id]

  depends_on = [aws_key_pair.sshkey,
    aws_subnet.public,
    aws_security_group.web,
  data.aws_ami.webimage]
}

# user_data = file("scripts.sh") instead of provisioners, inacse without using provisioners we can direct pass user data

# The primary use-case for the null resource is as a do-nothing containerfor arbitrary actions taken by a provisioner

resource "null_resource" "web_trigger" {
  triggers = {
    trigger_build_id = var.build_id
  }

  # Establishes connection to be used by all
  connection {
    type        = "ssh"
    user        = var.web_instance_info.username
    private_key = file(var.key-info.private_key_path)
    host        = aws_instance.web.public_ip
  }
  # generic remote provisioners (i.e. file/remote-exec)
  provisioner "remote-exec" {
    script = "./scripts.sh"
  }

}

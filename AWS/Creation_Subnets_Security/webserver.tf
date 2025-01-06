# create an ec2 instance resource with ubuntu 24.04
resource "aws_instance" "web" {
  ami                         = var.web_instance_info.ami
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
  aws_security_group.web]
}
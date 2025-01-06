# create an ec2 instance with ubuntu 24.04
resource "aws_instance" "web" {
  ami                         = "ami-053b12d3152c0cc71"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.sshkey.key_name
  associate_public_ip_address = true
  tags = {
    Name = "build"
  }
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web.id]
  depends_on = [aws_key_pair.sshkey,
    aws_subnet.public,
  aws_security_group.web]
}

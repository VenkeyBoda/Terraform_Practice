# create a security group for web
resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.base.id
  name        = var.web_security_group.name
  description = var.web_security_group.description
  tags = {
    name = var.web_security_group.name
  }
  depends_on = [aws_vpc.base]
}

# create a security group inbound rules
resource "aws_vpc_security_group_ingress_rule" "base" {
  count             = local.web_security_ingress_count
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = var.web_security_group.rules[count.index].cidr_ipv4
  from_port         = var.web_security_group.rules[count.index].from_port
  to_port           = var.web_security_group.rules[count.index].to_port
  ip_protocol       = var.web_security_group.rules[count.index].ip_protocol

}

# create a security group for default outbound rules
resource "aws_vpc_security_group_egress_rule" "default" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = -1

}

# create a security group for db
resource "aws_security_group" "db" {
  vpc_id      = aws_vpc.base.id
  name        = var.db_security_group.name
  description = var.db_security_group.description
  tags = {
    name = var.db_security_group.name
  }
  depends_on = [aws_vpc.base]
}

# create a db security group for inbound rules
resource "aws_vpc_security_group_ingress_rule" "db" {
  count             = local.db_security_ingress_count
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = var.db_security_group.rules[count.index].cidr_ipv4
  from_port         = var.db_security_group.rules[count.index].from_port
  to_port           = var.db_security_group.rules[count.index].to_port
  ip_protocol       = var.db_security_group.rules[count.index].ip_protocol

}

# create a db security group for default outbound rules
resource "aws_vpc_security_group_egress_rule" "dbdefault" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = -1

}

# importing an existing key pair the public key
resource "aws_key_pair" "sshkey" {
  key_name   = var.key-info.name
  public_key = file(var.key-info.public_key_path)

}
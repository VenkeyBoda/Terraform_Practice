# create a security group for base
resource "aws_security_group" "base" {
  vpc_id      = aws_vpc.base.id
  name        = "web-sg"
  description = "Allow  inbound traffic and all outbound traffic"
  tags = {
    name = "web-sg"
  }
  depends_on = [aws_vpc.base]
}

# create a security group inbound rules
resource "aws_vpc_security_group_ingress_rule" "base" {
  security_group_id = aws_security_group.base.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

}

# create a security group for default outbound rules
resource "aws_vpc_security_group_egress_rule" "default" {
  security_group_id = aws_security_group.base.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1

}

# create a security group for db
resource "aws_security_group" "db" {
  vpc_id      = aws_vpc.base.id
  name        = "db-sg"
  description = "Allow  inbound traffic and all outbound traffic"
  tags = {
    name = "db-sg"
  }
  depends_on = [aws_vpc.base]
}

# create a db security group for inbound rules
resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = "172.16.0.0/16"
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"

}

# create a db security group for default outbound rules
resource "aws_vpc_security_group_egress_rule" "dbdefault" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1

}

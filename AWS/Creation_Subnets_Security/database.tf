# create a RDS DB subnet group resource with private subnet
resource "aws_db_subnet_group" "private_subnets" {
  name       = "private_subnet_group"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name = "My private DB subnet group"
  }
  depends_on = [aws_instance.web, aws_vpc.base]
}

# create a RDS DB instance
resource "aws_db_instance" "rds" {
  allocated_storage    = var.db_instance_info.allocated_storage
  db_name              = var.db_instance_info.db_name
  engine               = var.db_instance_info.engine
  engine_version       = var.db_instance_info.engine_version
  instance_class       = var.db_instance_info.instance_class
  username             = var.db_instance_info.username
  password             = var.db_instance_info.password
  skip_final_snapshot  = var.db_instance_info.skip_final_snapshot
  db_subnet_group_name = aws_db_subnet_group.private_subnets.name

  # Attach the DB security group  
  vpc_security_group_ids = [aws_security_group.db.id]
  tags = {
    Name = "ec2_to_mysql_rds"
  }
}

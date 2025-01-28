# Define a module for creating a Virtual Private Cloud (VPC)
module "vpc" {
  source       = "github.com/VenkeyBoda/Modules_TF//AWS/vpc"
  vpc_cidr     = "10.0.0.0/16"
  vpc_name     = "web server"
  public_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
  public_az    = ["ap-south-1a", "ap-south-1b"]
  private_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
  private_az   = ["ap-south-1a", "ap-south-1b"]
}

# Define a module for creating security groups
module "security-group" {
  source                         = "github.com/VenkeyBoda/Modules_TF//AWS/security-group"
  vpc_id                         = module.vpc.vpc_id
  web_security_group_name        = "web-sg"
  web_security_group_description = "Allow inbound traffic and all outbound traffic"
  web_security_group_rules = [{
    from_port = 22
    to_port   = 22
    }, {
    from_port = 80
    to_port   = 80
  }]
  db_security_group_name        = "db-sg"
  db_security_group_description = "Allow inbound traffic and all outbound traffic"
  db_security_group = [{
    from_port = 3306
    to_port   = 3306
  }]
  depends_on = [module.vpc.vpc_id]
}

# Module for creating EC2 instances
module "ec2-instance" {
  source         = "github.com/VenkeyBoda/Modules_TF//AWS/EC2-Instance"
  instance_count = 2
  key-info = {
    name             = "my-key-pair"
    public_key_path  = "~/.ssh/id_rsa.pub"
    private_key_path = "~/.ssh/id_rsa"
  }
  web_instance_name                    = "web-server"
  web_instance_type                    = "t2.micro"
  instance_associate_public_ip_address = true
  instance_username                    = "ubuntu"
  filter_ami_name                      = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  filter_ami_owner                     = "099720109477"
  subnet_id                            = module.vpc.public_subnet_id
  vpc_security_group_ids               = module.security-group.web_security_id
  script                               = "./script.sh"
}

# Module for creating an RDS database
module "database_rds" {
  source                 = "github.com/VenkeyBoda/Modules_TF//AWS/RDS"
  subnet_ids             = module.vpc.private_subnet_id[*]
  subnet_group_name      = "my_db_subnet_group"
  database_name          = "ec2_to_mysql_rds"
  vpc_security_group_ids = module.security-group.web_security_id
}

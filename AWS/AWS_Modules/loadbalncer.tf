# Module for creating Loadbalancer
module "aws_loadbalancer" {
  source              = "github.com/VenkeyBoda/Modules_TF//AWS/Loadbalncer"
  target_instance_ids = module.ec2-instance.instance_ids
  aws_lb_name         = "cafe"
  aws_lb_type         = "network"
  subnets_id          = module.vpc.public_subnet_id
  lb_environment      = "dev"
  vpc_id              = module.vpc.vpc_id
  lb_protocol         = "TCP"
  lb_port             = 80
}

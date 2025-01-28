# # Output the URL of the web application
output "web-url" {
  value = module.ec2-instance.web_url

}

# Output the SSH command to connect to the EC2 instance
output "ssh-command" {
  value = module.ec2-instance.ssh_command

}

# Output the endpoint of the RDS database
output "rds_endpoint" {
  value = module.database_rds.rds_endpoint

}

# Output the HTTP website deployment information
output "http-website" {
  value = module.ec2-instance.deploy_server

}

# Output the URL of the Load Balancer created by the aws_loadbalancer module
output "lb_url" {
  value = module.aws_loadbalancer.url

}
output "vpc_id" {
  value = format(aws_vpc.main.id)
}

output "ssh_command" {
  value = format(
    "ssh %s@%s",
    var.web_instance_info.username, # Username for SSH access
    aws_instance.ec2.public_ip      # Public IP of the web instance
  )
  description = "SSH command to connect to the web server"
}
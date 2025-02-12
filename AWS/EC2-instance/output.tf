# Output the public URL for accessing the web server
output "web_url" {
  value       = format("http://%s", aws_instance.web[0].public_ip)
  description = "The public URL of the web server"

}

# Output the SSH command for connecting to the web server
output "ssh_command" {
  value = format(
    "ssh -i %s %s@%s",
    var.key-info.private_key_path,     # Path to the private key
    var.instance_username,             # Username for SSH access
    aws_instance.web[0].public_ip      # Public IP of the web instance
  )
  description = "SSH command to connect to the web server"
}

# Output the URL for accessing the deployed web server
output "deploy_server" {
  value = "http://${aws_instance.web[0].public_ip}"

}

# Output the total number of EC2 instances created
output "ec2-instance_count" {
  value = var.instance_count
  
}

# Output the IDs of all EC2 instances created by the 'web' resource
output "instance_ids" {
  value = aws_instance.web[*].id
}
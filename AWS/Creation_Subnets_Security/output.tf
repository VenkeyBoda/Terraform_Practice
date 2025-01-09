# ==========================
# Terraform Outputs
# ==========================

# VPC ID Output
output "vpc_id" {
  value       = aws_vpc.base.id
  description = "The ID of the VPC"
}

# Web Server URL Output
output "web_url" {
  value       = format("http://%s", aws_instance.web.public_ip)
  description = "The public URL of the web server"

}

# SSH Command Output
output "ssh_command" {
  value = format(
    "ssh -i %s %s@%s",
    var.key-info.private_key_path,  # Path to the private key
    var.web_instance_info.username, # Username for SSH access
    aws_instance.web.public_ip      # Public IP of the web instance
  )
  description = "SSH command to connect to the web server"
}

# deploy the server using templates output
output "deploy_server" {
  value = "http://${aws_instance.web.public_ip}/cafe"
}
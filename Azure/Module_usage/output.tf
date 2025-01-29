# ==========================
# Terraform Outputs
# ============

# web server URL output
output "web-url" {
  value       = module.virtual_machine.url
  description = "The public URL of the web server"
}

# SSH Command Output
output "ssh_command" {
  value = module.virtual_machine.ssh
}

# Template URL Output 
output "template_url" {
  value = module.virtual_machine.deploy_server

}

# Load Balancer Public IP Address Output
output "url_lb_ip_address" {
  value = module.azure_loadbalancer.public_ip_address

}
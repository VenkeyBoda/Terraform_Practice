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
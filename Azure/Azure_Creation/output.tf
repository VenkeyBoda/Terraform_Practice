# ==========================
# Terraform Outputs
# ============

# web server URL output
output "web-url" {
  value = format("http://%s",
  azurerm_linux_virtual_machine.web.public_ip_address)
  description = "The public URL of the web server"
}

# SSH Command Output
output "ssh_coomand" {
  value = format("ssh -i %s %s@%s",
    var.web_server_info.private_key_path,               # Path to the private key
    var.web_server_info.admin_username,                 # Username for SSH access
    azurerm_linux_virtual_machine.web.public_ip_address # Public IP of the web vm
  )
}
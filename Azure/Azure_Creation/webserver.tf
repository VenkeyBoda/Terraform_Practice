# create a vm with a network interface associated with nsg and public ip
resource "azurerm_linux_virtual_machine" "web" {
  count                 = var.vm_count
  name                  = "${var.web_server_info.name}-${count.index + 1}"
  location              = var.location_info
  resource_group_name   = azurerm_resource_group.base.name
  network_interface_ids = [azurerm_network_interface.web[count.index].id]
  size                  = var.web_server_info.size
  admin_username        = var.web_server_info.admin_username
  admin_ssh_key {
    username   = var.web_server_info.admin_username
    public_key = file(var.web_server_info.public_key_path)

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

  }
  depends_on = [azurerm_network_interface.web,
    azurerm_network_security_group.web,
    azurerm_subnet.web,
    azurerm_public_ip.base
  ]
}

# The primary use-case for the null resource is as a do-nothing containerfor arbitrary actions taken by a provisioner
resource "null_resource" "web" {
  count = var.vm_count
  triggers = {
    triggers_build_id = var.build_id
  }

  # Establishes connection to be used by all
  connection {
    host        = azurerm_linux_virtual_machine.web[count.index].public_ip_address
    type        = "ssh"
    user        = var.web_server_info.admin_username
    private_key = file(var.web_server_info.private_key_path)
  }

  # generic remote provisioners (i.e. file/remote-exec)
  provisioner "remote-exec" {
    script = "./nginx.sh"

  }
}

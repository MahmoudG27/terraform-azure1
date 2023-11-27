# Create two Azure virtual machines
resource "azurerm_virtual_machine" "wp-vm" {
  count                 = 2
  name                  = "wp-vm-${count.index}"
  location              = var.rg-location
  resource_group_name   = var.rg-name
  network_interface_ids = [azurerm_network_interface.wp-nic[count.index].id]
  vm_size               = var.vm-size

  storage_image_reference {
    publisher = "Canonical"
    offer     = var.offer-vm
    sku       = var.sku-vm
    version   = var.vm-version
  }

  storage_os_disk {
    name              = "my-vm-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myvm-${count.index}"
    admin_username = var.admin-vm
    admin_password = var.adminpasswd-vm
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
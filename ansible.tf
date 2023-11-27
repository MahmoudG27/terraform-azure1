# Create ansible VM
resource "azurerm_virtual_machine" "ansible-code" {
  name                  = "ansible-code"
  location              = var.rg-location
  resource_group_name   = var.rg-name
  network_interface_ids = [azurerm_network_interface.ansible-code-nic.id]
  vm_size               = var.vm-size

  storage_image_reference {
    publisher = "Canonical"
    offer     = var.offer-vm
    sku       = var.sku-vm
    version   = var.vm-version
  }

  storage_os_disk {
    name              = "ansible-code-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "ansible"
    admin_username = var.admin-vm
    admin_password = var.adminpasswd-vm
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_public_ip" "ansible-code-ip" {
  name                = "ansible-public-ip"
  location            = var.rg-location
  resource_group_name = var.rg-name
  allocation_method   = "Static"
  depends_on          = [azurerm_resource_group.wp-rg]
}

resource "azurerm_network_interface" "ansible-code-nic" {
  name                = "ansible-code-nic"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "ansible-code-ip-config"
    subnet_id                     = azurerm_subnet.wp-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ansible-code-ip.id
  }
}

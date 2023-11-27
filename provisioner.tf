resource "null_resource" "provision" {

  provisioner "local-exec" {
    command = <<EOT
    echo '[wordpress]
vm0 ansible_host=${azurerm_network_interface.wp-nic[0].private_ip_address} ansible_connection=ssh
vm1 ansible_host=${azurerm_network_interface.wp-nic[1].private_ip_address} ansible_connection=ssh' > ../ansible/inventory.ini
    EOT
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-add-repository ppa:ansible/ansible -y",
      "sudo apt update -y",
      "sudo apt install ansible sshpass -y",
      "yes '' | ssh-keygen -N '' > /dev/null",
      "sshpass -p '${var.adminpasswd-vm}' ssh-copy-id -o StrictHostKeyChecking=no ${var.admin-vm}@${azurerm_network_interface.wp-nic[0].private_ip_address}",
      "sshpass -p '${var.adminpasswd-vm}' ssh-copy-id -o StrictHostKeyChecking=no ${var.admin-vm}@${azurerm_network_interface.wp-nic[1].private_ip_address}",
      "mkdir wordpress && mkdir ansible",
    ]
    connection {
      type     = "ssh"
      user     = var.admin-vm
      password = var.adminpasswd-vm
      host     = azurerm_public_ip.ansible-code-ip.ip_address
    }
  }

  provisioner "file" {
    source      = "../wordpress"
    destination = "./"
    connection {
      type     = "ssh"
      user     = var.admin-vm
      password = var.adminpasswd-vm
      host     = azurerm_public_ip.ansible-code-ip.ip_address
    }
  }

  provisioner "file" {
    source      = "../ansible"
    destination = "./"
    connection {
      type     = "ssh"
      user     = var.admin-vm
      password = var.adminpasswd-vm
      host     = azurerm_public_ip.ansible-code-ip.ip_address
    }
  }
}
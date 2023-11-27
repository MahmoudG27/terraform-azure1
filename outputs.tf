# Output load balancer public IP
output "lb_public_ip" {
  value = azurerm_public_ip.wp-ip.ip_address
}

# Get private IP of VM0
output "vm1_private_ip" {
  value = azurerm_network_interface.wp-nic[0].private_ip_address
}

# Get private IP of VM1 
output "vm2_private_ip" {
  value = azurerm_network_interface.wp-nic[1].private_ip_address
}

# Get public IP of VM Ansible 
output "vm_ansible_public_ip" {
  value = azurerm_public_ip.ansible-code-ip.ip_address
}

# Get DNS of MySQL server 
output "mysql_server_dns" {
  value = azurerm_mysql_flexible_server.wp-mysql-server.fqdn
}
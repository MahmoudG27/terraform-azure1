# Create an Azure mysql flexible server
resource "azurerm_mysql_flexible_server" "wp-mysql-server" {
  name                   = var.mysql-name
  resource_group_name    = var.rg-name
  location               = var.rg-location
  administrator_login    = var.mysql-user
  administrator_password = var.mysql-user-password
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.wp-subnet2.id
  private_dns_zone_id    = azurerm_private_dns_zone.private-dns-mysql.id
  sku_name               = var.mysql-sku
  version                = var.mysql-version
  depends_on = [azurerm_private_dns_zone_virtual_network_link.link-vnet-mysql]
  
}

resource "azurerm_private_dns_zone" "private-dns-mysql" {
  name                = "wordpress.mysql.database.azure.com"
  resource_group_name = var.rg-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-vnet-mysql" {
  name                  = "MysqlVnetLink.com"
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-mysql.name
  virtual_network_id    = azurerm_virtual_network.wp-vnet.id
  resource_group_name   = var.rg-name
}

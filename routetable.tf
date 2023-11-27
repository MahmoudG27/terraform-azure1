#Route table for make connection subnet1 and subnet2
resource "azurerm_route_table" "wp_route_table" {
  name                = "wp-route-table"
  resource_group_name = var.rg-name
  location            = var.rg-location
  depends_on          = [azurerm_resource_group.wp-rg]
}

resource "azurerm_subnet_route_table_association" "subnet1_association" {
  subnet_id      = azurerm_subnet.wp-subnet1.id
  route_table_id = azurerm_route_table.wp_route_table.id
}

resource "azurerm_subnet_route_table_association" "subnet2_association" {
  subnet_id      = azurerm_subnet.wp-subnet2.id
  route_table_id = azurerm_route_table.wp_route_table.id
}
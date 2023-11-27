resource "azurerm_resource_group" "wp-rg" {
  name     = var.rg-name
  location = var.rg-location
}
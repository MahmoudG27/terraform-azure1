#Create Virtual Networks > Create Spoke Virtual Network
resource "azurerm_virtual_network" "wp-vnet" {
  name                = var.name-vnet
  location            = var.rg-location
  resource_group_name = var.rg-name
  address_space       = [var.address-vnet]
  depends_on          = [azurerm_resource_group.wp-rg]
}

#Create Subnet1 for VMs
resource "azurerm_subnet" "wp-subnet1" {
  name                 = var.name-subnet1
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.wp-vnet.name
  address_prefixes     = [var.address-subnet1]
}
#Create Subnet2 for MySQL
resource "azurerm_subnet" "wp-subnet2" {
  name                 = var.name-subnet2
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.wp-vnet.name
  address_prefixes     = [var.address-subnet2]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

#Create Private Network Interfaces
resource "azurerm_network_interface" "wp-nic" {
  count               = 2
  name                = "wp-nic-${count.index}"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "wp-nic-config-${count.index}"
    subnet_id                     = azurerm_subnet.wp-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create an Azure public IP address For Load Balancer
resource "azurerm_public_ip" "wp-ip" {
  name                = "publicIPForLB"
  location            = var.rg-location
  resource_group_name = var.rg-name
  sku                 = "Standard"
  allocation_method   = "Static"
  depends_on          = [azurerm_resource_group.wp-rg]
}
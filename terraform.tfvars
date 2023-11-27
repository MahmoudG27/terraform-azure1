rg-location = "North Europe"
rg-name     = "LAMP"

address-vnet    = "10.1.0.0/16"
address-subnet1 = "10.1.0.0/24"
address-subnet2 = "10.1.2.0/24"
name-vnet       = "wordpress-vnet"
name-subnet1    = "wordpress-subnet"
name-subnet2    = "mysql-subnet"


nsg1-name = "wp-nsg1"
nsg2-name = "wp-nsg2"

offer-vm       = "0001-com-ubuntu-server-focal"
sku-vm         = "20_04-lts"
vm-size        = "Standard_DS2_v2"
vm-version     = "latest"
admin-vm       = "mahmoud"
adminpasswd-vm = "Password123@"

mysql-name          = "wordpress-mysql-mg"
mysql-user          = "mahmoud"
mysql-user-password = "P@ssw0rd123@"
mysql-version       = "8.0.21"
mysql-sku           = "GP_Standard_D2ds_v4"
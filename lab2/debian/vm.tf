


resource "azurerm_resource_group" "rg2" {
  name = "rg-lab2-vm"
  location = "southcentralus"
}

resource "azurerm_network_interface" "nic1" {
  name = "${var.prefix}-nic1"
  resource_group_name = azurerm_resource_group.rg2.name
  location = azurerm_resource_group.rg2.location
  ip_configuration {
    name = "ipconfig-nic1"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  } 
}
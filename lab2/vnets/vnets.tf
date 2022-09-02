resource "azurerm_resource_group" "rg1" {
  name      = "rg-lab2-nw"
  location  = "southcentralus"
}

resource "azurerm_virtual_network" "hbnet" {
  name                = "vn-lab2-hb"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.100.0.0/22"] 
}

resource "azurerm_virtual_network" "sp1net" {
    name                = "vn-lab2-sp1"
    location            = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    address_space       = ["10.100.4.0/24"]
  
}

resource "azurerm_virtual_network_peering" "hb-to-sp1" {
  name = "hb-to-sp1"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.hbnet.name
  remote_virtual_network_id = azurerm_virtual_network.sp1net.id
  allow_forwarded_traffic = true 
  allow_virtual_network_access = true 
  use_remote_gateways = false 
}

resource "azurerm_virtual_network_peering" "sp1-to-hb" {
  name = "sp1-to-hb"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.sp1net.name
  remote_virtual_network_id = azurerm_virtual_network.hbnet.id
  allow_forwarded_traffic = true 
  allow_virtual_network_access = true 
  use_remote_gateways = false 
}



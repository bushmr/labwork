resource "azurerm_resource_group" "rg1" {
  name      = var.resGroup
  location  = var.region
}


resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets 
  location = var.region
  resource_group_name = azurerm_resource_group.rg1.name
  name = each.value["name"]
  address_space = each.value["address_prefixes"]
  
}

resource "azurerm_subnet" "hbsns" {
  for_each = var.hbsubnets
  name = each.value["name"]
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet["hubvnet"].name
  address_prefixes = each.value["address_prefixes"]
}

resource "azurerm_subnet" "spk1sns" {
  for_each = var.spk1subnets
  name = each.value["name"]
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet["spk1vnet"].name
  address_prefixes = each.value["address_prefixes"]
}

resource "azurerm_virtual_network_peering" "hb-to-sp1" {
  name = "hb-to-sp1"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet["hubvnet"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["spk1vnet"].id
  allow_forwarded_traffic = true 
  allow_virtual_network_access = true 
  use_remote_gateways = false 
}

resource "azurerm_virtual_network_peering" "sp1-to-hb" {
  name = "sp1-to-hb"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet["spk1vnet"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["hubvnet"].id
  allow_forwarded_traffic = true 
  allow_virtual_network_access = true 
  use_remote_gateways = false 
}



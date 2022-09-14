output "resGroup_name_out" {
  value = azurerm_resource_group.rg1.name
}

output "region_out" {
  value = azurerm_resource_group.rg1.location
}

output "sp1sub_id_out" {
  value = {
    for id in keys(var.spk1subnets) : id => azurerm_subnet.spk1sns[id].id
  }
}

output "hb1sub_id_out" {
  value = {
    for id in keys(var.hbsubnets) : id => azurerm_subnet.hbsns[id].id
  }
}


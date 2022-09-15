resource "azurerm_public_ip" "pipazfw" {
  name = "pip-lab2-azfw"
  resource_group_name = var.resGroup
  location = var.location
  sku = "Standard"
  allocation_method = "Static"
}

resource "azurerm_firewall" "azfw" {
  name = var.fwname
  location = var.location
  resource_group_name = var.resGroup
  sku_name = "AZFW_VNet"
  sku_tier = "Premium"

  ip_configuration {
    name = "fw_ipConfig"
    subnet_id = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pipazfw.id
  }
}

resource "azurerm_firewall_policy" "azfwpol" {
  name = var.azfwpol
  location = var.location
  resource_group_name = var.resGroup
  sku = "Premium"
  threat_intelligence_mode = "Alert"
  intrusion_detection {
    mode = "Deny"
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "azfwnrcg" {
  name = "${var.netrulcol}-grp" 
  firewall_policy_id = azurerm_firewall_policy.azfwpol.id
  priority = 1000 
  depends_on = [
    azurerm_firewall_policy.azfwpol
  ]
  
  network_rule_collection {
    name = var.netrulcol
    priority = 1000
    action = "Allow"
    rule {
      name = "AllowHTTPS-Outbound"
      source_addresses = ["10.100.0.0/16"]
      destination_ports = ["443"]
      destination_addresses = ["*"]
      protocols = ["TCP","UDP"]
   }
  }
}
resource "azurerm_resource_group" "rgtst" {
  name = "rg-vmss-tst"
  location = "southcentralus"
}

resource "azurerm_orchestrated_virtual_machine_scale_set" "vmss" {
name = "${var.prefix}-vmss"
location = var.location
resource_group_name = azurerm_resource_group.rgtst.name
platform_fault_domain_count = 2
sku_name = "Standard_D3_v2"
instances = 2
 network_interface {
  primary = true
  name = "${var.prefix}-nic0"
  enable_accelerated_networking = false
  enable_ip_forwarding = false
  ip_configuration {
    name  = "nic0"
    subnet_id = var.mgmt
  }
 }
 network_interface {
  name = "${var.prefix}-nic1"
  enable_accelerated_networking = false
  enable_ip_forwarding = false
  ip_configuration {
    name = "nic1"
    subnet_id = var.diag
  }
 }

 network_interface {
    name = "${var.prefix}-nic2"
    enable_accelerated_networking = true
    enable_ip_forwarding = true
    ip_configuration {
      name = "nic2"
      subnet_id = var.outside
      public_ip_address {
        name = "${var.prefix}-pip2"
        sku_name = "Standard_Regional"
      }
    }
 }

 network_interface {
    name = "${var.prefix}-nic3"
    enable_accelerated_networking = true
    enable_ip_forwarding = true
    ip_configuration {
      name = "nic3"
      subnet_id = var.inside
    }
 }

 os_profile {
  linux_configuration {
    #populate username and password prior to plan/deploy
    admin_username = ""
    admin_password = ""
    disable_password_authentication = false
  }
 }
 
 plan {
  name = "ftdv-azure-byol"
  publisher = "cisco"
  product = "cisco-ftdv"
 }

 source_image_reference {
   publisher = "cisco"
   offer     = "cisco-ftdv"
   sku       = "ftdv-azure-byol"
   version   = "70288.0.0"
 }
}




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

resource "azurerm_linux_virtual_machine" "vm1" {
  name = "${var.prefix}-vm1"
  resource_group_name = azurerm_resource_group.rg2.name
  location = azurerm_resource_group.rg2.location
  size = "Standard_B1s"
  admin_username = "cadmin"
  admin_ssh_key {
    username = "cadmin"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "debian"
    offer = "debian-11"
    sku = "11-gen2"
    version = "latest"
  }
  boot_diagnostics {}
  

}
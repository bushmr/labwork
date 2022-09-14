resource "azurerm_public_ip" "pip-elb" {
  name = var.pipName
  location = var.location
  resource_group_name = var.rg_name
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "secElb" {
  name                = "elb-fw-001"
  location            = var.location
  resource_group_name = var.rg_name
  sku = "Standard"
  sku_tier = "Regional"

  frontend_ip_configuration {
    name                 = "lbfe-fw-ext"
    public_ip_address_id = azurerm_public_ip.pip-elb.id
    
    #subnet_id = var.outside_sub
  }
}

resource "azurerm_lb" "secIlb" {
  name                = "ilb-fw-001"
  location            = var.location
  resource_group_name = var.rg_name
  sku = "Standard"
  sku_tier = "Regional"

  frontend_ip_configuration {
    name                 = "lbfe-fw-int"
    subnet_id = var.inside_sub
  
    private_ip_address_allocation = "Dynamic"
  }
}
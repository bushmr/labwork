variable "resGroup" {
  type = string
  description = "Resource Group"
}

variable "location" {
  type = string
  description = "Azure Region"
}

variable "fwname" {
  type = string
  description = "Name of Azure Firewall"
}

variable "subnet_id" {
  type = string
  description = "ID of the AzureFirewallSubnet"
}

variable "azfwpol" {
  type = string
  description = "Azure Firewall Policy Name"
}

variable "netrulcol" {
  type = string
  description = "Network Rule Collection for Azure Firewall Policy"
}
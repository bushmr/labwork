variable "resGroup" {
  type = string
  description = "Resource Group Name"
}

variable "location" {
  type = string
  default = "Azure Region"
}

variable "prefix" {
  type = string
  description = "Name prefix for items"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID"
}
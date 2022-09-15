variable "prefix" {
  type = string
  description = "naming Prefix"
}

variable "resGroup" {
  type = string
  description = "Azure Resource Group"
  
}
variable "location" {
  type = string
  description = "Azure Region"
}
variable "mgmt" {
  type = string
  description = "Management Subnet"
}

variable "diag" {
  type = string
  description = "Diagnostics Subnet"
}

variable "outside" {
  type = string
  description = "Outside Subnet"
}

variable "inside" {
  type = string
  description = "Inside Subnet"
}
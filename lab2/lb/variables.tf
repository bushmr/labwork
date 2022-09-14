variable "rg_name" {
  type = string
  description = "Resource Group from networking"
}

variable "location" {
    type = string
    description = "Azure Region"
}

variable "outside_sub" {
  type = string
  description = "Outside Subnet" 
}

variable "inside_sub" {
  type = string
  description = "Inside Subnet"
}

variable "pipName" {
    type = string
    description = "Public IP for External Load Balancer"
  
}
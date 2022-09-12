variable "resGroup" {
  type = string
  description = "Resource Group Name"
}

variable "region" {
    type = string
    description = "Azure Region / Location"
  
}

variable "vnets" {
    type = map(any)
    default = {
      "hubvnet" = {
        name = "vn-lab2-hb1"
        address_prefixes = ["10.100.0.0/22"]
      }
      "spk1vnet" = {
        name = "vn-lab2-spk1"
        address_prefixes = ["10.100.4.0/24"]
      }
    }
}

variable "hbsubnets" {
    type = map(any)
    default = {
      "sub1" = {
        name = "sn-lab2-def-hb1"
        address_prefixes = ["10.100.0.0/27"]
      }
      "sub2" = {
        name = "sn-lab2-fwmgt-hb1"
        address_prefixes = ["10.100.0.32/27"]
      }
      "sub3" = {
        name = "sn-lab2-fwdia-hb1"
        address_prefixes = ["10.100.0.128/27"]
      }
      "sub4" = {
        name = "sn-lab2-fwout-hb1"
        address_prefixes = ["10.100.0.64/27"]
      }
      "sub5" = {
        name = "sn-lab2-fwin-hb1"
        address_prefixes = ["10.100.0.96/27"]
      }
    }
  
}

variable "spk1subnets" {
  type = map(any)
  default = {
    "sub1" = {
        name = "sn-lab2-def-sp1"
        address_prefixes = ["10.100.4.0/27"]
    } 
  }
}
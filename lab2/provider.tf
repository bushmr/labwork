terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
  }
}

 #call provider
provider "azurerm" {
    features {}
    subscription_id = "a86f7777-3773-436f-b016-8fa3759b637d"
    alias           = "msdn"
}

#had to add to prevent error stating must have at least 1
#feature block - weird behavior
provider "azurerm" {
  features {}
}
# provider "azurerm" {
#     alias           = "SAP_NonProd"
#     subscription_id = "aXXXXX7777-xxxx-ffff-b016-8fa375XXXXXX"
#     features {}
# }


#call modules
module "vnets" {
  source = "./vnets"
  region = "southcentralus"
  resGroup = "rg-tf-test"
}

# module "debian" {
#   source = "./debian"
#   prefix = "dev"
#   subnet_id = module.vnets.sub_id_out
# }


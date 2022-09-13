#call modules
module "vnets" {
  source = "./vnets"
  region = "southcentralus"
  resGroup = "rg-tf-test"
}

module "debian" {
  source = "./debian"
  prefix = "dev"
  resGroup = "rg-tf-test"
  subnet_id = module.vnets.sp1sub_id_out["sub1"]
}

# module "cisco" {
#   source = "./cisco"
#   prefix = "ftdv"
#   location = "southcentralus"
#   inside = module.vnets.hb1sub_id_out["sub5"]
#   outside = module.vnets.hb1sub_id_out["sub4"]
#   mgmt = module.vnets.hb1sub_id_out["sub2"]
#   diag = module.vnets.hb1sub_id_out["sub3"]
# }


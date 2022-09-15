#call modules
module "vnets" {
  source = "./vnets"
  region = "westus3"
  resGroup = "rg-zz-net"
}

# module "debian" {
#   source = "./debian"
#   prefix = "dev"
#   resGroup = "rg-tf-test"
#   subnet_id = module.vnets.sp1sub_id_out["sub1"]
# }

# module "lb" {
#   source = "./lb"
#   rg_name = module.vnets.resGroup_name_out
#   location = module.vnets.region_out
#   outside_sub = module.vnets.hb1sub_id_out["sub4"]
#   inside_sub = module.vnets.hb1sub_id_out["sub5"]
#   pipName = "pip-elb-fw"
# }

# module "cisco" {
#   source = "./cisco"
#   prefix = "ftdv"
#   location = module.vnets.region_out
#   resGroup = module.vnets.resGroup_name_out
#   inside = module.vnets.hb1sub_id_out["sub5"]
#   outside = module.vnets.hb1sub_id_out["sub4"]
#   mgmt = module.vnets.hb1sub_id_out["sub2"]
#   diag = module.vnets.hb1sub_id_out["sub3"]
# }

module "azfw" {
  source = "./azfw"
  fwname = "azfw-lab2-001"
  location = module.vnets.region_out
  resGroup = module.vnets.resGroup_name_out
  subnet_id = module.vnets.hb1sub_id_out["sub6"]
  azfwpol = "azfw-pol-lab2-001"
  netrulcol = "NetworkRuleCollection"
}
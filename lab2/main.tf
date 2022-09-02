#call modules
module "vnets" {
  source = "./vnets"
}

module "debian" {
  source = "./debian"
  prefix = "vm"
  subnet_id = module.vnets.sub_id_out
}
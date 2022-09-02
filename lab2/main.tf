#call modules
module "vnets" {
  source = "./vnets"
}

module "debian" {
  source = "./debian"
  prefix = "dev"
  subnet_id = module.vnets.sub_id_out
}


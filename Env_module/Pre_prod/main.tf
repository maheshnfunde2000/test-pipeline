module "resource_groups" {
  source              = "../../child_modules/resource_groups"
  resource_group_name = var.resource_group_name
}

module "virtual_network" {
  depends_on           = [module.resource_groups]
  source               = "../../child_modules/virtual_network"
  virtual_network_name = var.virtual_network_name
}

module "subnet" {
  depends_on  = [module.virtual_network]
  source      = "../../child_modules/subnet"
  subnet_name = var.subnet_name
}



module "public_ip" {
  depends_on     = [module.resource_groups]
  source         = "../../child_modules/public_ip"
  public_ip_name = var.public_ip_name
}

module "virtual_machine" {
  depends_on = [module.subnet, module.public_ip, module.resource_groups, module.virtual_network, ]
  source     = "../../child_modules/virtual_machine"
  vms        = var.vms
}

# client_secret = "my-secret"# client_secret = "my-secret"

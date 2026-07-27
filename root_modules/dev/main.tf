module "rgs" {
  source = "../../child_modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "vnet" {
  depends_on = [module.rgs]
  source     = "../../child_modules/azurerm_virtual_network"
  vnets      = var.vnets
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../child_modules/azurerm_subnet"
  subnets    = var.subnets
}

module "pips" {
  depends_on = [module.rgs]
  source     = "../../child_modules/azurerm_public_ip"
  pips       = var.pips
}

module "bastions" {
  depends_on = [module.subnet, module.pips]
  source     = "../../child_modules/azurerm_bastion_host"
  bastions   = var.bastions
}

module "vms" {
  depends_on = [module.subnet, module.keyvaults_secrets]
  source     = "../../child_modules/azurerm_linux_virtual_machine"
  vms        = var.vms
}

module "keyvaults" {
  depends_on = [module.rgs]
  source     = "../../child_modules/azurerm_key_vault"
  keyvaults  = var.keyvaults
}

module "keyvaults_secrets" {
  depends_on        = [module.keyvaults]
  source            = "../../child_modules/azurerm_key_vault_secret"
  keyvaults_secrets = var.keyvaults_secrets
}
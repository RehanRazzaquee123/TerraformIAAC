module "RGTest" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
module "VnetTest" {
  source             = "../../modules/azurerm_virtual_network"
  vnets              = var.vnets
  rgName_From_Module = module.RGTest.rg_names
}
module "NSGTest" {
  source             = "../../modules/azurerm_nsg_connection"
  nsgs               = var.nsgs
  rgName_From_Module = module.RGTest.rg_names
  ssh                = var.ssh
  http               = var.http
}
module "Subnet" {
  source               = "../../modules/azurerm_subnet_network"
  subnets              = var.subnets
  rgName_From_Module   = module.RGTest.rg_names
  vnetName_From_Module = module.VnetTest.rg_vnets
}
module "NICCardTest" {
  source               = "../../modules/azurerm_nic_card"
  subnetid_From_Module = module.Subnet.rg_subnetids
  vnetid_From_Module   = module.VnetTest.rg_vnetids
  pips                 = var.pips
  rgName_From_Module   = module.RGTest.rg_names
  nic1                 = var.nic1
  nic2                 = var.nic2
  subnets              = var.subnets
  vnetName_From_Module = module.VnetTest.rg_vnets
  vm1name              = var.vm1name
  vm2name              = var.vm2name
  osdiskname           = var.osdiskname
  datadiskname         = var.datadiskname
  nic_nsg1             = var.nic_nsg1
  nic_nsg2             = var.nic_nsg2
  nsgName_From_Module  = module.NSGTest.rg_nsgs
  peering              = var.peering
}
module "AppGateway" {
  source               = "../../modules/azurerm_application_gateway"
  subnetid_From_Module = module.Subnet.rg_subnetids
  pip_From_Module      = module.NICCardTest.pipids
  nic_private_ip      = module.NICCardTest.nic_private_ip
}
module "ContainerRegistry" {
  depends_on         = [module.RGTest]
  source             = "../../modules/azurerm_container_registry"
  cr                 = var.cr
  rgName_From_Module = module.RGTest.rg_names

}

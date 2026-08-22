resource "azurerm_subnet" "subnets" {
  for_each=tomap(var.subnets)
  name                 = each.value.name
  resource_group_name  = var.rgName_From_Module[each.value.rg_key]
  virtual_network_name = var.vnetName_From_Module[each.value.vnet_key]
  address_prefixes     = each.value.address_prefixes
 }
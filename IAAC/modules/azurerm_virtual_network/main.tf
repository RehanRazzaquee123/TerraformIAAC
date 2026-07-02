resource "azurerm_virtual_network" "vnets" {
  for_each=tomap(var.vnets)
  name                = each.value.name
  location            = each.value.location
  resource_group_name = var.rgName_From_Module[each.value.rg_key]
  address_space       = each.value.address_space
}

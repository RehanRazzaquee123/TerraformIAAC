output "rg_vnets" {
  value = {
    for k, vnet in azurerm_virtual_network.vnets :
    k => vnet.name
  }
}
output "rg_vnetids" {
  value = {
    for k, vnet in azurerm_virtual_network.vnets :
    k => vnet.id
  }
}
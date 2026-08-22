output "rg_subnets" {
  value = {
    for k, subnet in azurerm_subnet.subnets :
    k => subnet.name
  }
}
output "rg_subnetids" {
  value = {
    for k, subnet in azurerm_subnet.subnets :
    k => subnet.id
  }
}
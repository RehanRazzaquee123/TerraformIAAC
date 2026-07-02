output "rg_nsgs" {
  value = {
    for k, nsg in azurerm_network_security_group.NSGS :
    k => nsg.id
  }
}
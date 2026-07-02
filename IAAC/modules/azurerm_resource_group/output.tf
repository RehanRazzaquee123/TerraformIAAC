output "rg_names" {
  value = {
    for k, rg in azurerm_resource_group.rgTf :
    k => rg.name
  }
}
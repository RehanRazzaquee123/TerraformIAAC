resource "azurerm_resource_group" "rgTf" {
  for_each=tomap(var.rgs)
  name     = each.value.name
  location = each.value.location
}
resource "azurerm_container_registry" "acr" {
  name                = var.cr.crname
  resource_group_name = var.rgName_From_Module["rg1"]
  location            = var.cr.location
  sku                 = var.cr.sku
  admin_enabled       = var.cr.admin_enabled
}
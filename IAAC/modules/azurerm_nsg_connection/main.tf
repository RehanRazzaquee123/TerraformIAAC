resource "azurerm_network_security_group" "NSGS" {
  for_each=tomap(var.nsgs)
  name                = each.value.name
  location            = each.value.location
  resource_group_name = var.rgName_From_Module[each.value.rg_key]
}
resource "azurerm_network_security_rule" "ssh" {
  for_each=tomap(var.ssh)
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = var.rgName_From_Module[each.value.rg_key]
  network_security_group_name = azurerm_network_security_group.NSGS[each.value.nsg_key].name
  #var.rgName_From_Module[var.ssh.rg_key]
  #azurerm_network_security_group.NSGS[var.ssh.nsg_key].name
}

resource "azurerm_network_security_rule" "http" {
  for_each=tomap(var.http)
  name                        = "Allow-HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = var.rgName_From_Module[each.value.rg_key]
  network_security_group_name =  azurerm_network_security_group.NSGS[each.value.nsg_key].name
}
resource "azurerm_network_security_rule" "product" {
  for_each=tomap(var.http)
  name                        = "Allow-Product"
  priority                    = 111
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8081"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = var.rgName_From_Module[each.value.rg_key]
  network_security_group_name =  azurerm_network_security_group.NSGS[each.value.nsg_key].name
}
resource "azurerm_network_security_rule" "order" {
  for_each=tomap(var.http)
  name                        = "Allow-Order"
  priority                    = 112
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8082"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = var.rgName_From_Module[each.value.rg_key]
  network_security_group_name =  azurerm_network_security_group.NSGS[each.value.nsg_key].name
}
resource "azurerm_network_security_rule" "user" {
  for_each=tomap(var.http)
  name                        = "Allow-User"
  priority                    = 113
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8083"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = var.rgName_From_Module[each.value.rg_key]
  network_security_group_name =  azurerm_network_security_group.NSGS[each.value.nsg_key].name
}

resource "azurerm_subnet" "subnets" {
  for_each=tomap(var.subnets)
  name                 = each.value.name
  resource_group_name  = var.rgName_From_Module[each.value.rg_key]
  virtual_network_name = var.vnetName_From_Module[each.value.vnet_key]
  address_prefixes     = each.value.address_prefixes
 }

resource "azurerm_public_ip" "pip" {
  name                = var.pip.name
  location            = var.pip.location
  resource_group_name = var.rgName_From_Module[var.pip.rg_key]
  allocation_method   = var.pip.allocation_method
  sku                 = var.pip.sku
}

resource "azurerm_network_interface" "nic1" {
  depends_on=[azurerm_public_ip.pip,azurerm_subnet.subnets]
  name                = var.nic1.name
  location            = var.nic1.location
  resource_group_name = var.rgName_From_Module[var.nic1.rg_key]

  ip_configuration {
    
    name                          = var.nic1.ip_configuration.name
    subnet_id                     = azurerm_subnet.subnets["subnet1"].id
    private_ip_address_allocation = var.nic1.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
resource "azurerm_network_interface" "nic2" {
  depends_on=[azurerm_subnet.subnets]
  name                = var.nic2.name
  location            = var.nic2.location
  resource_group_name = var.rgName_From_Module[var.nic2.rg_key]

  ip_configuration {
    name                          = var.nic2.ip_configuration.name
    subnet_id                     = azurerm_subnet.subnets["subnet2"].id
    private_ip_address_allocation = var.nic2.ip_configuration.private_ip_address_allocation    
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg1" {
  depends_on=[azurerm_network_interface.nic1]
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = var.nsgName_From_Module[var.nic_nsg1.nsg_key]
}

resource "azurerm_network_interface_security_group_association" "nic_nsg2" {
  depends_on=[azurerm_network_interface.nic2]
  network_interface_id      = azurerm_network_interface.nic2.id
  network_security_group_id = var.nsgName_From_Module[var.nic_nsg2.nsg_key]
}

resource "azurerm_virtual_machine" "tvm1" {
  depends_on=[azurerm_network_interface.nic1]
  name                  = var.vm1name.name
  location              = var.vm1name.location
  resource_group_name   = var.rgName_From_Module[var.vm1name.rg_key]
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = var.vm1name.vm_size
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.vm1name.admin_username
    admin_password = var.vm1name.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = var.osdiskname.name
    caching           = var.osdiskname.caching
    create_option     = var.osdiskname.create_option
    managed_disk_type = var.osdiskname.storage_account_type
  }
}

resource "azurerm_virtual_machine" "tvm2" {
  name                  = var.vm2name.name
  location              = var.vm2name.location
  resource_group_name   = var.rgName_From_Module[var.vm2name.rg_key]
  network_interface_ids = [azurerm_network_interface.nic2.id]
  vm_size               = var.vm2name.vm_size
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.vm2name.admin_username
    admin_password = var.vm2name.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = var.datadiskname.name
    caching           = var.datadiskname.caching
    create_option     = var.datadiskname.create_option
    managed_disk_type = var.datadiskname.storage_account_type
}
}
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                         = "vnet1-to-vnet2"
  resource_group_name          = var.rgName_From_Module[var.peering.rg_key1]
  virtual_network_name         = var.vnetName_From_Module[var.peering.vnet_key1]
  remote_virtual_network_id    = var.vnetid_From_Module[var.peering.vnet_id2]
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                      = "vnet2-to-vnet1"
  resource_group_name       = var.rgName_From_Module[var.peering.rg_key2]
  virtual_network_name      = var.vnetName_From_Module[var.peering.vnet_key2]
  remote_virtual_network_id = var.vnetid_From_Module[var.peering.vnet_id1]
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}
output "pipids" {
  value = {
    for k, pip in azurerm_public_ip.pip :
    k => pip.id
  }
}
output "nic_private_ip" {
  value = azurerm_network_interface.nic1.private_ip_address
}
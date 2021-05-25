output "privateIP" {
  value = azurerm_network_interface.rhel.private_ip_address
}

output "PublicIp" {
  value = azurerm_public_ip.rhel.ip_address
}

output "VMID" {
  value = azurerm_virtual_machine.rhel.id
}

output "VMNAME" {
  value = azurerm_virtual_machine.rhel.name
}
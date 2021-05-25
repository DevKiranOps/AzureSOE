resource "azurerm_network_security_group" "soe" {
  name                = "rhelsoe-sg"
  location            = azurerm_resource_group.soe.location
  resource_group_name = azurerm_resource_group.soe.name
}


resource "azurerm_network_security_rule" "ssh" {
  name                        = "AZAgent"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
  source_address_prefix      = "*"
  resource_group_name         = azurerm_resource_group.soe.name
  network_security_group_name = azurerm_network_security_group.soe.name
}


resource "azurerm_subnet_network_security_group_association" "rhel" {
  subnet_id                 = azurerm_subnet.apps.id
  network_security_group_id = azurerm_network_security_group.soe.id
}
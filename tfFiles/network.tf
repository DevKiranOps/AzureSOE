resource "azurerm_virtual_network" "rhel" {
  name = var.vnetName
  resource_group_name = azurerm_resource_group.soe.name 
  location = azurerm_resource_group.soe.location
  address_space = [var.vnetcidr]
}


resource "azurerm_subnet" "apps" {
  name = var.subnet
  resource_group_name = azurerm_resource_group.soe.name 
  virtual_network_name = azurerm_virtual_network.rhel.name
  address_prefixes = [var.subnetcidr]
}

resource "azurerm_public_ip" "rhel" {
  name                = "${var.prefix}rhelsoe-pip"  
  location            = azurerm_resource_group.soe.location
  resource_group_name = azurerm_resource_group.soe.name
  allocation_method   = "Static"
  tags = var.tags
}


resource "azurerm_network_interface" "rhel" {
  name                = "${var.prefix}rhelsoe-nic"
  location            = azurerm_resource_group.soe.location
  resource_group_name = azurerm_resource_group.soe.name
  depends_on          = [azurerm_public_ip.rhel]

  ip_configuration {
    name                          = "configuration"
    subnet_id                     =  azurerm_subnet.apps.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = azurerm_public_ip.rhel.id
    
  }
  tags=var.tags
}


#Fetch the Cloudinit (userdate) file

data "template_file" "ansible" {
  template = file("${path.module}/Templates/cloudnint-ansible.tpl")
}

data "template_file" "key_data" {
  template = file("${path.module}/id_rsa.pub")
}


resource "azurerm_virtual_machine" "rhel" {
  name                  = "${var.prefix}rhelsoe"
  location              = azurerm_resource_group.soe.location
  resource_group_name   = azurerm_resource_group.soe.name
  network_interface_ids = [azurerm_network_interface.rhel.id]
  vm_size               = var.rhel_vm_size
  tags=var.tags

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  # This means the Data Disk Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku 
    version   = var.osversion
  }

  storage_os_disk {
    name              = "${var.prefix}rhelsoe-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}rhelsoe"
    admin_username = var.username      
    // custom_data    = data.template_file.ansible.rendered
    
  }

  os_profile_linux_config {
    disable_password_authentication = true

     ssh_keys {
     key_data = data.template_file.key_data.rendered
     path     = var.destination_ssh_key_path
     }
  }
}


resource "null_resource" remoteExecProvisionerWFolder {

  provisioner "file" {
    source      = "../ansible"
    destination = "/home/vmlocaladmin/"
  }


 provisioner "remote-exec" {
    inline = [
      "sudo yum -y install python3 python3-pip",
      "sudo pip3 install ansible",      
      "ansible --version",
      "cd ansible",
      "export ANSIBLE_LOG_PATH=ansible.log",
      "ansible-playbook cisplaybook.yaml",
      "sudo waagent -deprovision+user -force"       
      
    ]
  }

  connection {
    host     = azurerm_public_ip.rhel.ip_address
    type     = "ssh"
    user     = var.username    
    private_key = file("${path.module}/id_rsa")
    agent    = "false"
  }
}
variable "prefix" {
}

variable "location" {
  default =  "australiaeast"
}

variable "resourcegroup" {
  description = "Resource Group where the deployment is done"
}

variable "env" {
  description = "Environment"
}
variable "vnetName" {
  description = "Name of the VNET where the subnet exists"
}

variable "vnetcidr" {
  description = "CIDR Range"
}

variable "subnet" {
  description = "Name of the subnet where VM is deployed"
}

variable "subnetcidr" {
  description = "Address Space for Subnet"
}

variable "username" {
}

variable "destination_ssh_key_path" {
  default = "/home/vmlocaladmin/.ssh/authorized_keys"
}

variable "tags" {
  type = map(string)

  default = {
    Deploymode="TF"
    Environment="uat"
    usecase="soe"
  }

  description = "Any tags which should be assigned to the resources in this example"
}


# Rhel variables

variable "rhel_vm_size" {

  description = "Size of the SOE VM"
}


variable "publisher" {

}

variable "offer" {

}

variable "sku" {

}


variable "osversion" {

}
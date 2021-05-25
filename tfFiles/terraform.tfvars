prefix="cops"
location="#LOCATION#"
resourcegroup="#RESOURCEGROUP#"
env="uat"
vnetName="soevnet"
vnetcidr="10.0.0.0/16"
subnet="Apps"
subnetcidr="10.0.0.0/24"
rhel_vm_size="Standard_B2s"
publisher="RedHat"
offer="RHEL"
sku="8.1"
osversion="8.1.2020020415"
username="vmlocaladmin"
destination_ssh_key_path="/home/vmlocaladmin/.ssh/authorized_keys"
tags = {
    Project = "CloudOps"
    Module="SOE"
    DeployMode="TF"
    Environment="uat"
    
  }


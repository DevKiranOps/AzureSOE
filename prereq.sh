#!/bin/bash

source ./vars.ini
TFRESOURCEGROUP=$1
TFSTORAGEACCOUNT=$2
TFCONTAINERNAME=$3
TFKEY=$4

# Downgrading Terraform to 0.13 for Compatibility issues

rm -r $(which terraform)
wget https://releases.hashicorp.com/terraform/0.13.6/terraform_0.13.6_linux_amd64.zip 
unzip terraform_0.13.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform
terraform --version


# sudo apt-get update && sudo apt-get install jq dnsutils -y

AGENTIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# Replace Variables in Terraform config
sed -i "s,#RESOURCEGROUP#,${RESOURCEGROUP}," tfFiles/terraform.tfvars
sed -i "s,#LOCATION#,${LOCATION}," tfFiles/terraform.tfvars
sed -i "s,#TFRESOURCEGROUP#,${TFRESOURCEGROUP}," tfFiles/tfremote.tf
sed -i "s,#TFSTORAGEACCOUNT#,${TFSTORAGEACCOUNT}," tfFiles/tfremote.tf
sed -i "s,#TFCONTAINERNAME#,${TFCONTAINERNAME}," tfFiles/tfremote.tf
sed -i "s,#TFCONTAINERNAME#,${TFCONTAINERNAME}," tfFiles/tfremote.tf
sed -i "s,#TFKEY#,${TFKEY}," tfFiles/tfremote.tf
sed -i "s,#AGENTIP#,${AGENTIP}," tfFiles/nsg.tf

sudo chmod 400 id_rsa
sudo chmod 600 id_rsa.pub
cp id_rsa id_rsa.pub tfFiles/

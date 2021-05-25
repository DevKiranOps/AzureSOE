#!/bin/bash


source ./vars.ini

echo "Create resource Group"
az group create --name $RESOURCEGROUP --location $LOCATION
existingvnet=$(az network vnet list --resource-group $RESOURCEGROUP --query "[?name=='${vnetName}'].{Name:name}" -otsv)
if [ -z $existingvnet ]
then
    echo "vnet doesn't exist creating"
    echo "Create VNET"
    az network vnet create --name $vnetName --resource-group $RESOURCEGROUP \
                           --address-prefixes $vnetcidr

else
    echo "Virtual Network $existingvnet already exists"
fi

existingsubnet=$(az network vnet subnet list --vnet-name $vnetName --resource-group $RESOURCEGROUP  --query "[?name=='$subnet'].{Name:name}" -otsv)
if [ -z $existingsubnet ]
then 
    echo "Subnet doesn't exist... creating"
    echo "Create subnet"
    az network vnet subnet create --resource-group $RESOURCEGROUP --name $subnet \
                                  --vnet-name $vnetName --address-prefixes $subnetcidr
else
    echo "subnet $existingsubnet exists"
fi


echo "End of BaseBuild"
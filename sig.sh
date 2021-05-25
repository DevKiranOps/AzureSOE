#!/bin/bash

source ./vars.ini

cd tfFiles/

# echo get VMID and VMNAME from the Terraform Output
VMID=$(terraform output VMID)

VMNAME=$(terraform output VMNAME)

echo $VMNAME

# az sig create --resource-group $SIGRG --gallery-name $GALLERYNAME 

az vm deallocate \
    --resource-group $RESOURCEGROUP \
    --name $VMNAME

az vm generalize \
    --resource-group $RESOURCEGROUP \
    --name $VMNAME


patch=2;#PatchNumberThatIsIncremented

IMAGEVERSION="$major.$minor.$patch"
echo "Create Image Version"
az sig image-version create --resource-group $SIGRG --gallery-name $GALLERYNAME \
                               --gallery-image-definition $IMAGEDEFINTION  --gallery-image-version $IMAGEVERSION \
                               --managed-image $VMID --tag \
                               --target-regions australiaeast=2 australiasoutheast

# Increment the Patch Number for Next Run

cd ..
next_patch=$[$patch+1]
sed -i "/#PatchNumberThatIsIncremented$/s/=.*#/=$next_patch;#/" ${0}

echo "Get the Image ID for VM Creation"
IMGID=$(az sig image-version list --resource-group $SIGRG \
                                  --gallery-name $GALLERYNAME  \
                                  --gallery-image-definition $IMAGEDEFINTION \
                                  --query "[-1].id" -otsv)
echo $IMGID
echo "Create VM with the new image"
az vm create --resource-group $SIGRG --name rhelsoe --image $IMGID \
             --size "Standard_B1s" --admin-username $username \
             --ssh-key-values tfFiles/id_rsa.pub 

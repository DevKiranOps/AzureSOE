terraform {
  backend "azurerm" {
    resource_group_name  = "#TFRESOURCEGROUP#"
    storage_account_name = "#TFSTORAGEACCOUNT#"
    container_name       = "#TFCONTAINERNAME#"
    key                  = "#TFKEY#"
  }
}

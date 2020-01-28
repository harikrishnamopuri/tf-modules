resource "azurerm_storage_account" "sa" {
  name                     = var.storageaccountname
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

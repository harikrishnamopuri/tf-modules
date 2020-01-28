resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    Terraform = "True"
  }
}
resource "azurerm_storage_container" "sc" {
  depends_on = [azurerm_storage_account.sa]
  name                  = var.sc_name
# resource_group_name   = var.rg_name
  storage_account_name  = var.sa_name
  container_access_type = var.container_access_type
  
}

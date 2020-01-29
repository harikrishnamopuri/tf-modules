resource "azurerm_availability_set" "aset" {
  name                = var.aset_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  managed                      = var.aset_managed_type
  tags = var.tags  
}

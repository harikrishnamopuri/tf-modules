resource "azurerm_container_registry" "acr" {
  name                     = join("", [var.name,var.env,lower(var.region)])
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.rg_location
  sku                      = var.sku
  admin_enabled            = var.admin
#  georeplication_locations = var.geo_replication
}
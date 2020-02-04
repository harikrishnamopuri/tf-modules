#####################
provider "azurerm" {
  version = "~> 1.35"
}

resource "azurerm_container_registry" "acr" {
  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  sku                      = var.sku
  admin_enabled            = var.admin
#  georeplication_locations = var.geo_replication
}

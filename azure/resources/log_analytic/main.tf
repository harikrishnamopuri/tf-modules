resource "azurerm_log_analytics_workspace" "log_analytics" { 
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = var.sku
#  retention_in_days   = var.retention
}

resource "azurerm_log_analytics_solution" "log_analytics" {
  solution_name         = "ContainerInsights"
  location              = var.rg_location
  resource_group_name   = var.rg_name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  workspace_name        = azurerm_log_analytics_workspace.log_analytics.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

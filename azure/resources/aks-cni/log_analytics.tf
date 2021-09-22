resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    #name                = join("-",["test", var.env, lower(var.region), random_id.log_analytics_workspace_name_suffix.dec])
    name                = join("-",["test", random_id.log_analytics_workspace_name_suffix.dec])
    location            = var.rg_location
    resource_group_name = azurerm_resource_group.rg.name
    sku                 = var.log_analytics_workspace_sku
}
resource "azurerm_log_analytics_solution" "log_analytics_workspace_solution" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.log_analytics_workspace.location
    resource_group_name   = azurerm_resource_group.rg.name
    workspace_resource_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
    workspace_name        = azurerm_log_analytics_workspace.log_analytics_workspace.name
    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

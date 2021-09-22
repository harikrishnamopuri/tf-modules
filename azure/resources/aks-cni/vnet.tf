resource "azurerm_virtual_network" "vn" {
  name                = "test-vnet"
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}
resource "azurerm_subnet" "subnet" {
  count      = length(var.subnet_names)
  depends_on = [azurerm_virtual_network.vn]
  name       = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = "test-vnet"
  address_prefix       = var.subnet_prefixes[count.index] 
#  azurerm_subnet_network_security_group_association = lookup(var.nsg_ids,var.subnet_names[count.index],"")
}

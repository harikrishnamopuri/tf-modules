
resource "azurerm_virtual_network" "vn" {
  name                = var.vn_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}
resource "azurerm_subnet" "subnet" {
  count      = length(var.subnet_names)
  depends_on = [azurerm_virtual_network.vn]
  name       = var.subnet_names[count.index]
  resource_group_name  = var.rg_name
  virtual_network_name = var.vn_name
  address_prefix       = var.subnet_prefixes[count.index] 
  azurerm_subnet_network_security_group_association = lookup(var.nsg_ids,var.subnet_names[count.index],"")
}


resource "azurerm_virtual_network" "vn" {
  name                = var.vn_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  
  tags = {
    Terraform = "True"
  }
}


resource "azurerm_subnet" "pub_subnet" {
  count                = length(var.public_subnets)
  name                 = format(
      "pub-%s-%d",
      var.vn_name,
      count.index) 
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefix       = element(var.public_subnets, count.index)
}
resource "azurerm_subnet" "private_subnet" {
  count                = length(var.private_subnets)
  name                 = format(
      "priv-%s-%d",
      var.vn_name,
      count.index)
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefix       = element(var.private_subnets, count.index)

}

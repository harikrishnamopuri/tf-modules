
resource "azurerm_virtual_network" "vn" {
  name                = var.vn_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  
  tags = {
    Terraform = "True"
  }
}
resource "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  depends_on = [azurerm_virtual_network.vn]
  name                 = format(
      "sub-%s-%d",
      var.vn_name,
      count.index)
  resource_group_name  = var.rg_name
  virtual_network_name = var.vn_name
  address_prefix       = element(var.subnets, count.index)

}

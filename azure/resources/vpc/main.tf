
resource "azurerm_virtual_network" "vn" {
  name                = var.vn_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  
  tags = {
    Terraform = "True"
  }
}

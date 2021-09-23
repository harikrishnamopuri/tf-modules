resource "azurerm_resource_group" "rg" {
  name     = join("-", [var.name,var.env,lower(var.region),"rg"])
  location = var.rg_location
  tags = {
    Terraform = "True"
  }
}

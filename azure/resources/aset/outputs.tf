output "aset_name" {
  value = azurerm_availability_set.aset.name
}
output "aset_id" {
  value = azurerm_availability_set.aset.id
}
output "aset_rg_name" {
  value = var.rg_name
}
output "aset_location" {
  value = var.rg_location
}

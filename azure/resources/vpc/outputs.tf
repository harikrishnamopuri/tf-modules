output "vn_id" {
  value =  azurerm_virtual_network.vn.id
}
output "vn_name" {
  value =  azurerm_virtual_network.vn.name
}
output "vn_location" {
  value =  azurerm_virtual_network.vn.location
}
output "vn_address_space" {
  value =  azurerm_virtual_network.vn.address_space
}
output "subnet_name" {
  value = [ azurerm_subnet.subnet.*.name ]
}
output "subnet_prefix" {
  value = [ azurerm_subnet.subnet.*.address_prefix ]
}
output "subnet_id" {
  value = [ azurerm_subnet.subnet.*.id ]
}

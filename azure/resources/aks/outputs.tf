output "fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "sp_id" {
  value = azuread_service_principal.aks.id
}

output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = false
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive = false
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive = false
}

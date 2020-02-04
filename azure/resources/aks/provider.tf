provider "azurerm" {
  version = "~> 1.37"
}

provider "azuread" {
  version = "~> 0.6"
}

provider "kubernetes" {
  version = "~> 1.9"

  host = azurerm_kubernetes_cluster.aks.kube_config[0].host
  client_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate,
  )
  client_key = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].client_key,
  )
  cluster_ca_certificate = base64decode(
    azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate,
  )
}

provider "random" {
  version = "~> 2.2"
}


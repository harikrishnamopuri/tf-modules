terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.0.0"
    }
    kubernetes = {
    version = "1.13.4"
   }
   azuread = {
     source  = "hashicorp/azuread"
     version = "0.11.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.3.0"
    }
  }
}
provider "azurerm" {
  features {}
}


provider "kubernetes" {
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
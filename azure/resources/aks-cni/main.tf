#https://github.com/neumanndaniel/terraform/blob/master/modules/aks/main.tf
#https://github.com/ToruMakabe/container-handson/blob/1342101525cfd2b8de7f357a0cf8481ee85f16f9/prep/modules/aks/main.tf#L25
# Resources section #
data "azuread_client_config" "current" {}
data "azurerm_subscription" "current" {}


resource "azuread_group" "ad" {
  name     = "example-ad"
 #owners           = [data.azuread_client_config.current.object_id]
#  security_enabled = true
} 

resource "azuread_application" "aks" {
  name = var.name
}

resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.application_id
}

resource "azuread_service_principal_password" "aks" {
  service_principal_id = azuread_service_principal.aks.id
  value                = random_password.aks.result
  end_date_relative    = "8760h"
}

resource "azurerm_role_assignment" "aks_mon" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azuread_service_principal.aks.id
}

resource "azurerm_role_assignment" "aks_subnet" {
  scope                = azurerm_subnet.subnet[0].id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.aks.id
}

resource "azurerm_role_assignment" "acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.aks.id
}
resource "azurerm_role_assignment" "vnet" {
  scope                = azurerm_virtual_network.vn.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aks.id
}

resource "azurerm_role_assignment" "aks" {
  depends_on           = [azuread_service_principal_password.aks]
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aks.id

  // Waiting for AAD global replication
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

 
resource "random_password" "aks" {
  length  = 20
  special = true
}


resource "azurerm_kubernetes_cluster" "aks" {
  depends_on          = [azurerm_role_assignment.aks]
  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }

  name                            = "test"
  location                        = var.rg_location
  resource_group_name             = azurerm_resource_group.rg.name
  dns_prefix                      = var.name
  kubernetes_version              = var.kubernetes_version
  node_resource_group             = "${var.name}-worker"
  api_server_authorized_ip_ranges = var.api_auth_ips

  default_node_pool {
    name                = substr(var.default_node_pool.name, 0, 12)
    node_count          = var.default_node_pool.node_count
    vm_size             = var.default_node_pool.vm_size
    type                = "VirtualMachineScaleSets"
#    availability_zones  = var.default_node_pool.zones
    max_pods            = 50
    os_disk_size_gb     = 128
    vnet_subnet_id      = azurerm_subnet.subnet[0].id
    node_taints         = var.default_node_pool.taints
    enable_auto_scaling = var.default_node_pool.cluster_auto_scaling
    min_count           = var.default_node_pool.cluster_auto_scaling_min_count
    max_count           = var.default_node_pool.cluster_auto_scaling_max_count
  }

  service_principal {
    client_id     = azuread_service_principal.aks.application_id
    #client_id     = var.client_id
    #client_secret = var.client_secret
    client_secret = azuread_service_principal_password.aks.value
  }

  #identity {
  #  type = "SystemAssigned"
  #}

  role_based_access_control {
    enabled = true

#    azure_active_directory {
#      client_app_id     = var.aad_client_application_id
#      server_app_id     = var.aad_server_application_id
#      server_app_secret = var.aad_server_application_secret
#      tenant_id         = var.aad_tenant_id
#    }
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
    }
    kube_dashboard {
      enabled = false
    }
  }

  network_profile {
    load_balancer_sku  = "standard"
    network_plugin     = "azure"
    network_policy     = "calico"
    dns_service_ip     = "192.168.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "192.168.0.0/16"
  }
  #provisioner "local-exec" {
  #  command = <<EOT
  #    az aks get-credentials -g "${azurerm_resource_group.rg.name}"  -n test --overwrite-existing ;
  #  EOT
  #}

}

resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  lifecycle {
    ignore_changes = [
      node_count
    ]
  }

  for_each = var.additional_node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = substr(each.key, 0, 12)
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size
 # availability_zones    = each.value.zones
  max_pods              =  50
  os_disk_size_gb       = 128
  os_type               = "Linux"
  #vnet_subnet_id        = var.vnet_subnet_id
  vnet_subnet_id        = azurerm_subnet.subnet[0].id
  #vnet_subnet_id        = "/subscriptions/e92f9656-592f-4279-945c-91fefb05a97d/resourceGroups/testhari/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1"
  node_taints           = each.value.taints
  enable_auto_scaling   = each.value.cluster_auto_scaling
  min_count             = each.value.cluster_auto_scaling_min_count
  max_count             = each.value.cluster_auto_scaling_max_count
}


resource "kubernetes_cluster_role_binding" "aks" {
  metadata {
    name = "aks-cluster-admins"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = azuread_group.ad.id
  }
}

variable "client_id" { default = "9eb29a30-48b7-499f-9b58-fc1c5b47eae3" }
variable "client_secret" { default = ":h5B8F?6pP5[bu:41t_JrL-x6OQbl[XA" }
variable "container_registry_id" {
  description = "Resource id of the ACR"
  type        = string
  default     = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourceGroups/dummy/providers/Microsoft.ContainerRegistry/registries/dummy"
}

variable "log_analytics_workspace_id" {
  description = "Resource id of the Log Analytics workspace"
  type        = string
  default   = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourcegroups/dummy/providers/microsoft.operationalinsights/workspaces/dummyharikrishna"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.15.7"
}

variable "name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "cmhari"
}

variable "rg_name" {
  description = "Name of the AKS cluster resource group"
  type        = string
  default     = "dummy"
}

variable "rg_location" {
  description = "Azure region of the AKS cluster"
  type        = string
  default      = "West US"
}

variable "vnet_subnet_id" {
  description = "Resource id of the Virtual Network subnet"
  type        = string
  default     = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourceGroups/dummy/providers/Microsoft.Network/virtualNetworks/dummy/subnets/subnet1"
}

#variable "aad_client_application_id" {
#  description = "Client application id for AAD integration"
#  type        = string
#}

#variable "aad_server_application_id" {
#  description = "Server application id for AAD integration"
#  type        = string
#}

#variable "aad_server_application_secret" {
#  description = "Server application secret for AAD integration"
#  type        = string
#}

#variable "aad_tenant_id" {
#  description = "AAD tenant id for AAD integration"
#  type        = string
#}

variable "aad_group_name" {
  description = "Name of the Azure AD group for cluster-admin access"
  type        = string
  default     = "test"
}

#variable "api_auth_ips" {
#  description = "Whitelist of IP addresses that are allowed to access the AKS Master Control Plane API"
#  type        = list(string)
#}

variable "default_node_pool" {
  description = "The object to configure the default node pool with number of worker nodes, worker node VM size and Availability Zones."
  type = object({
    name                           = string
    node_count                     = number
    vm_size                        = string
    zones                          = list(string)
    taints                         = list(string)
    cluster_auto_scaling           = bool
    cluster_auto_scaling_min_count = number
    cluster_auto_scaling_max_count = number
  })
}

variable "additional_node_pools" {
  description = "The map object to configure one or several additional node pools with number of worker nodes, worker node VM size and Availability Zones."
  type = map(object({
    node_count                     = number
    vm_size                        = string
    zones                          = list(string)
    taints                         = list(string)
    cluster_auto_scaling           = bool
    cluster_auto_scaling_min_count = number
    cluster_auto_scaling_max_count = number
  }))
}

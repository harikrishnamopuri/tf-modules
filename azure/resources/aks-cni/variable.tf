variable "client_id" { default = "9eb29a30-48b7-499f-9b58-fc1c5b47eae3" }
variable "client_secret" { default = ":h5B8F?6pP5[bu:41t_JrL-x6OQbl[XA" }

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.20.9"
}

variable "name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "astra"
}

variable "env" {
  description = "The name of the AKS env"
  type        = string
  default     = "stg"
}
variable "region" {
  description = "Azure region of the AKS cluster"
  type        = string
  default      = "westus"
}
variable "rg_location" {
  description = "Azure region of the AKS cluster"
  type        = string
  default      = "West US"
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

variable "api_auth_ips" {
  description = "Whitelist of IP addresses that are allowed to access the AKS Master Control Plane API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

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

###################Vnet variables###########
variable "address_space" {
  type = list
  default = ["10.0.0.0/16"]
}

#subnet required vairables
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1"]
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map

  default = {
  }
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map

  default = {
    tag1 = ""
    tag2 = ""
  }
}

######## acr variables ####

variable "sku" {
  description = "The SKU of the ACR"
  type        = string
  default     = "basic"
}

variable "admin" {
  description = "Admin access enabled"
  type        = bool
  default   = true
}

#variable "geo_replication" {
#  description = "Azure regions for ACR geo replication"
#  type        = list(string)
#  default    = [ "West US" ]
#}


#####log analytics####

variable log_analytics_workspace_sku {
  type = string
  default ="PerGB2018"
}
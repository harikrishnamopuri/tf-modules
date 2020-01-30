variable "client_id" { default = "9eb29a30-48b7-499f-9b58-fc1c5b47eae3" }
variable "client_secret" { default = ":h5B8F?6pP5[bu:41t_JrL-x6OQbl[XA" }
variable "rg_name" {
 default = "dummy"
}
variable "rg_location" {
    default = "West US"
}
variable "agent_count" {
    default = 1
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "k8stest"
}

variable cluster_name {
    default = "k8stest-hari"
}

variable resource_group_name {
    default = "azure-k8stest"
}

variable location {
    default = "Central US"
}

variable log_analytics_workspace_name {
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}

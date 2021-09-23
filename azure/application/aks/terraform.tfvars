kubernetes_version = "1.20.9"
name="astrasre"
env="stg"
region="westus"
rg_location="West US"
api_auth_ips=["0.0.0.0/0","222.222.22.22/32"]
default_node_pool = {
    name                           = "nodepool1"
    node_count                     = 1
    vm_size                        = "Standard_D2_v3"
    zones                          = ["1", "2"]
    taints                         = null
    cluster_auto_scaling           = false
    cluster_auto_scaling_min_count = null
    cluster_auto_scaling_max_count = null
}
  additional_node_pools = {
#    pool2 = {
#      node_count = 1
#      vm_size    = "Standard_D4_v3"
#      zones      = ["1", "2"]
#      node_os    = "Windows"
#      taints = [
#        "kubernetes.io/os=windows:NoSchedule"
#      ]
#      cluster_auto_scaling           = false
#      cluster_auto_scaling_min_count = null
#      cluster_auto_scaling_max_count = null
#    }
}

#vnet variable
address_space=["10.0.0.0/16"]
subnet_prefixes=["10.0.1.0/24"]
subnet_names=["subnet1"]




log_analytics_workspace_sku="PerGB2018"
admin="true"
sku="Basic"


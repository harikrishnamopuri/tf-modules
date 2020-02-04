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

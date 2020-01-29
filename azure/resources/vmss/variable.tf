variable "vmss_name" {
 default = "demo"
}

variable "rg_location" {
 default = "West US"
}

variable "rg_name" {
 default = "dummy"
}

# automatic rolling upgrade

variable "automatic_os_upgrade" {
 default = "true"
}

variable "upgrade_policy_mode" {
 default = "Rolling"
}

variable "max_batch_instance_percent" {
 default = "20"
}

variable "max_unhealthy_instance_percent" {
 default = "20"
}

variable "max_unhealthy_upgraded_instance_percent" {
 default = "5"
}
variable "pause_time_between_batches" {
 default = "PT0S"
}

# required when using rolling upgrade policy
variable "health_probe_id" {
 default = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourceGroups/dummy/providers/Microsoft.Network/loadBalancers/azure_lb-lb/probes/http"
}

#sku
variable "sku_name" {
 default = "Standard_F2"
}

variable "sku_tier" {
 default = "Standard"
}

variable "capacity" {
 default = "2"
}

#image_publisher
variable "image_publisher" {
 default = "Canonical"
}

variable "image_offer" {
 default = "UbuntuServer"
}

variable "image_sku" {
 default = "16.04-LTS"
}

variable "image_version" {
 default = "latest"
}

#storage profile os disk
variable "disk_name" {
 default = ""
}

variable "disk_caching" {
 default = "ReadWrite"
}

variable "disk_create_option" {
 default = "FromImage"
}

variable "managed_disk_type" {
 default = "Standard_LRS"
}
#data disk

variable "data_disk_caching" {
 default = "ReadWrite"
}

variable "data_create_option" {
 default = "Empty"
}

variable "data_disk_size_gb" {
 default = "1"
}
variable "cm_prefix" {
 default = "demovm"
}
variable "admin_user_name" {
 default = "hari"
}
variable "key_path" {
 default = "/home/hari/.ssh/authorized_keys"
}
variable "key_pub_file" {
 default = "/home/harikrishna/.ssh/id_rsa.pub"
}
variable "subnet_id" {
 default = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourceGroups/dummy/providers/Microsoft.Network/virtualNetworks/dummy/subnets/subnet1"
}
variable "load_balancer_backend_address_pool_ids" {
 default = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourceGroups/dummy/providers/Microsoft.Network/loadBalancers/azure_lb-lb/backendAddressPools/azure_lb-BackEndAddressPool"
}
variable "load_balancer_inbound_nat_rules_ids" {
# default = "/subscriptions/b95112e4-7fe7-4f99-a2bd-65ec04aaa72e/resourceGroups/dummy/providers/Microsoft.Network/loadBalancers/azure_lb-lb/inboundNatRules/VM-0"
  default = ""
}
variable "tags" {
  type = map

  default = {
    source = "terraform"
  }
}

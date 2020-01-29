resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  # automatic rolling upgrade
  automatic_os_upgrade = var.automatic_os_upgrade
  upgrade_policy_mode  = var.upgrade_policy_mode

  rolling_upgrade_policy {
    max_batch_instance_percent              = var.max_batch_instance_percent
    max_unhealthy_instance_percent          = var.max_unhealthy_instance_percent
    max_unhealthy_upgraded_instance_percent = var.max_unhealthy_upgraded_instance_percent
    pause_time_between_batches              = var.pause_time_between_batches
  }

  # required when using rolling upgrade policy
  health_probe_id = var.health_probe_id

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  storage_profile_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_profile_os_disk {
    name              = ""
    caching           = var.disk_caching
    create_option     = var.disk_create_option
    managed_disk_type = var.managed_disk_type
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = var.data_disk_caching
    create_option = var.data_create_option
    disk_size_gb  = var.data_disk_size_gb
  }

  os_profile {
    computer_name_prefix = var.cm_prefix
    admin_username       = var.admin_user_name
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = var.key_path
      key_data = file(var.key_pub_file)
    }
  }

  network_profile {
    name    = format("%s-net-profile", var.vmss_name)
    primary = true

    ip_configuration {
      name                                   = format("%s-ip-conf", var.vmss_name)
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.load_balancer_backend_address_pool_ids]
#      load_balancer_inbound_nat_rules_ids    = [var.load_balancer_inbound_nat_rules_ids]
    }
  }

  tags = var.tags
}

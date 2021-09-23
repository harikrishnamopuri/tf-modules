module "aks" {
  source                     = "../../resources/aks-cni"
  #aks variables
  kubernetes_version = var.kubernetes_version
  name = var.name
  env  = var.env
  region = var.region
  rg_location = var.rg_location
  api_auth_ips = var.api_auth_ips
  default_node_pool = var.default_node_pool
  additional_node_pools = var.additional_node_pools

 
  #vnet variable
  address_space = var.address_space
  dns_servers = var.dns_servers
  subnet_prefixes = var.subnet_prefixes
  subnet_names = var.subnet_names
  nsg_ids = var.nsg_ids
  tags = var.tags

  #acr variables
  log_analytics_workspace_sku = var.log_analytics_workspace_sku
  admin = var.admin
  sku = var.sku
}

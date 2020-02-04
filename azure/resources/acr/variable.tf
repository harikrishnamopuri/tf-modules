variable "rg_name" {
  description = "Name of the ACR resource group"
  type        = string
  default = "dummy"
}

variable "rg_location" {
  description = "Azure region of the ACR"
  type        = string
  default = "West US"
}

variable "name" {
  description = "The name of the ACR"
  type        = string
  default  = "dummy"
}

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

variable "geo_replication" {
  description = "Azure regions for ACR geo replication"
  type        = list(string)
  default    = [ "West US" ]
}

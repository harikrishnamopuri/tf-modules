variable "rg_name" {
  type = string
  default = "dummy"
}
variable "rg_location" {
  type = string
  default = "West US"
}
variable "aset_name" {
  type = string
  default = "demo"
}
variable "platform_update_domain_count" {
  default = 5
}
variable "platform_fault_domain_count" {
  default = 3
}
variable "aset_managed_type" {
  default = true
}

variable "tags" {
  type = map

  default = {
    source = "terraform"
  }
}

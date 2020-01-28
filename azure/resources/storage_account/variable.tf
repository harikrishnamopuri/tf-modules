variable "storageaccountname" {
  type = string
  default = "storageaccounthari"
}
variable "rg_name" {
  type = string
  default = "dummy"
}
variable "rg_location" {
  type = string
  default = "West US"
}
variable "account_tier" {
  type = string
  default = "Standard"
}
variable "account_replication_type" {
  type = string
  default = "GRS"
}

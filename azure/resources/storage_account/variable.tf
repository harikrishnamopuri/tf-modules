#storage account required variables
variable "sa_name" {
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
#container required variables
variable "sc_name" {
  type = string
  default = "storagecontainer"
}
variable "container_access_type" {
  type = string
  default = "private"
}

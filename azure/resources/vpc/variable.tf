variable "vn_name" {
  type = string
  default = "dummy"
}
variable "address_space" {
  type = list
  default = ["10.0.0.0/16"]
}
variable "rg_name" {
  type = string
  default = "dummy"
}
variable "rg_location" {
  type = string
  default = "West US"
}

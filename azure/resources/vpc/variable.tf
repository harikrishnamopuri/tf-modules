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

#subnet required vairables
variable "subnets" {
   type =  list
   default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

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
variable "public_subnets" {
   type =  list
   default = [ "10.1.0.0/16" ] 
}
variable "private_subnets" {
   type =  list
   default = [ "10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16" ]
}

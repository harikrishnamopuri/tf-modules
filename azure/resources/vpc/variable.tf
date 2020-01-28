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
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1"]
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map

  default = {
  }
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map

  default = {
    tag1 = ""
    tag2 = ""
  }
}

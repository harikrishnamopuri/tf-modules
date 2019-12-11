variable "instance_tenancy" {
    type = string
}
variable "name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "zones" {
  type = list
}

variable "public_subnets" {
  type = list
}

variable "private_subnets" {
  type = list
}


variable "vm_subnets" {
  type    = list
  default = []
}

variable "region" {
  type = string
}

# BUG: Cannot generate count off calculated assignment
#   https://github.com/hashicorp/terraform/issues/10857
variable "num_peers" {
  type    = string
  default = 0
}

variable "peers" {
  type    = list
  default = []
}


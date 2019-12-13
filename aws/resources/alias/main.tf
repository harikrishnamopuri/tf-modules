
# Variables must declare type, so provide all
#   the different types as possible variables
variable "string" {
  type    = string
  default = ""
}

variable "list" {
  type    = list(string)
  default = []
}

variable "map" {
  type    = map(string)
  default = {}
}

output "string" {
  value = var.string
}

output "list" {
  value = var.list
}

output "map" {
  value = var.map
}


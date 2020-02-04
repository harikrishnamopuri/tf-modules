variable "name" {
  description = "The name of the Log Analytics workspace"
  type        = string
  default     = "dummyharikrishna"
}

variable "rg_name" {
  description = "Name of the Log Analytics workspace resource group"
  type        = string
  default     = "dummy"
}

variable "rg_location" {
  description = "Azure region of the Log Analytics workspace"
  type        = string
  default     = "West US"
}

variable "sku" {
  description = "The SKU of the Log Analytics workspace"
  type        = string
  default     = "Standard"
}

variable "retention" {
  description = "The retention time of the Log Analytics workspace"
  type        = number
  default     = 500
}

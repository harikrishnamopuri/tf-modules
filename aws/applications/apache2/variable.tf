variable "region" {
  type = string
  default  = "us-east-2"
}

variable "app_name" {
  type = string
  default  = "apache2"
}


# Required variables
variable "vpc_id" {
  type = string
  default = "vpc-0c427ec6219254801"
}

variable "private_subnets" {
  type = list(string)
  default = ["subnet-02cdef7337949ff93",  "subnet-0a6c51199f52047d4",  "subnet-09b5d958f07382c7f"]
}

variable "ami" {
  type = string
  default = "ami-a2e544da"
}

variable "env" {
  type = string
  default = "dev"
}

variable "ansible_role" {
  type = string
  default = "test"
}

variable "role_name" {
   type = string 
   default  = "hari.mopuri"
}

#asr lb
variable "asr_spinnaker_managed" {
  type    = string
  default = "false"
}

variable "asr_asg_suffix" {
  type    = string
  default = ""
}

variable "asr_frigga_detail" {
  type    = string
  default = ""
}

variable "apache2_ports" {
  type = map(string)

  default = {
    inbound = 8080
  }
}

variable "apache2_lb" {
  type   = string
  default = "true"

}


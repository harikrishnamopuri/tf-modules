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

variable "lb_type" {
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


variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_key" {
  type    = string
  default = "hari-test"
}

variable "ebs_type" {
  type    = string
  default = "gp2"
}

variable "ebs_size" {
  type    = string
  default = 30
}

variable "ebs_delete" {
  type    = string
  default = "true"
}

# Instance (autoscaling)

variable "health_check_type" {
  type    = string
  default = "ELB"
}

variable "launch_time" {
  type    = string
  default = 600
}

variable "max_size" {
  type    = string
  default = 1
}

variable "min_size" {
  type    = string
  default = 1
}
variable "desired_capacity" {
  type    = string
  default = 1
}
variable "state_env" {
  type    = string
  default = "default"
}

variable "termination_policies" {
  type    = list(string)
  default = ["OldestInstance"]
}
variable "asg_suffix" {
  type    = string
  default = ""
}
variable "account" {
  type    = string
  default = "dev"
}


variable "aws_launch_conf" {
  type  = string
  default  = "true"
}
variable "autoscaling_group" {
  type  = string
  default  = "true"
}


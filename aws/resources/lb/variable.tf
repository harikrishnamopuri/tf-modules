variable "app_name" {
  type = string
}


variable "subnets" {
  type = list(string)
}

variable "type" {
  description = "Type of loadbalacner (allowed values: clb, alb, or nlb)"
  default     = "alb"
}

variable "extra_target_group_arns" {
  type    = list(string)
  default = []
}

variable "env" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "account" {
  type    = string
  default = "dev"
}

variable "listener_lb" {
  type = list
}

#  port, dest_port, cert_arn

variable "listener_srv" {
  type = list
}

#  port              healthy(3),    interval(5),  check_path('/')
#  protocol('HTTP')  unhealthy(2),  timeout(3)
#  cluster_sg,       cluster_name

# Optional variables

variable "idle_timeout" {
  type    = string
  default = 60
}

variable "internal" {
  type    = string
  default = "true"
}

variable "health_check_type" {
  type    = string
  default = "EC2"
}

variable "launch_time" {
  type    = string
  default = "600"
}

variable "state_env" {
  type    = string
  default = "default"
}

variable "stickiness" {
  type    = string
  default = "true"
}

variable "del_protect" {
  type    = string
  default = "false"
}

variable "conn_drain" {
  type    = string
  default = "true"
}

variable "conn_drain_timeout" {
  type    = string
  default = 400
}

variable "cross_zone_balancing" {
  type    = string
  default = "true"
}


variable "asg_suffix" {
  type    = string
  default = ""
}
variable "apache2_lb" {
  type   = string 
  default = "true"

}


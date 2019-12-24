
variable "app_name" {
  type = string
}


# Required variables
variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "env" {
  type = string
}


# Optional variables
variable "ami_os" {
  type        = string
  default     = ""
  description = "'Ubuntu' / 'Cent OS' / 'windows'. default selection is ubuntu"
}

variable "ansible_branch" {
  type    = string
  default = "master"
}

variable "extra_security_groups" {
  type    = list(string)
  default = []
}


# Launch config
variable "instance_profile" {
  type    = string
  default = "krishna"
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

# Optional tags
variable "custom_tag0" {
  type = map(string)

  default = {
    "Name"  = "custom_tag0"
    "Value" = "n/a"
  }
}


variable "asg_suffix" {
  type    = string
  default = ""
}
variable "account" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "us-west-1"
}

variable "aws_launch_conf" {
  type  = string
  default  = "true"
}
variable "autoscaling_group" {
  type  = string
  default  = "true"
}


module "apache2" {
       source = "../../resources/asg"
       app_name = var.app_name
       private_subnets = var.private_subnets
       vpc_id   = var.vpc_id
       ami      = var.ami
       env      = var.env      
       ansible_role = var.ansible_role
       instance_profile = module.apache2_iam.instance_profile_arn
}
module "apache2_lb" {
  source = "../../resources/lb"

  app_name      = var.app_name
  vpc_id        = var.vpc_id
  subnets       = var.private_subnets
  env           = var.env

  type            = "alb"
  internal        = "true"
  apache2_lb      = var.apache2_lb

  listener_lb = [
    {
      port      = var.apache2_ports["inbound"]
      dest_port = var.apache2_ports["inbound"]
    },
  ]

  listener_srv = [
    {
      "port" = var.apache2_ports["inbound"]
    },
  ]
}

resource "aws_autoscaling_attachment" "apache2_healthcheck_lb" {
  count                  = var.apache2_lb == "true" ? 0 : 1
  autoscaling_group_name = element(module.apache2.asg_id, 0)
  elb                    = module.apache2_lb.lb_id
}


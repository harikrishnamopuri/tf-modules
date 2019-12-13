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


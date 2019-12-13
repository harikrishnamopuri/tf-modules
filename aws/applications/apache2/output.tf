output "asg_id" {
  value = module.apache2.asg_id
}

output "asg_name" {
  value = module.apache2.asg_name
}

output "alf_name" {
   value = module.apache2.alf_name
}

output "sg" {
  value = module.apache2.sg
}

output "instance_profile_arn" {
  value = module.apache2_iam.instance_profile_arn
}
output "instance_role_name" {
  value = module.apache2_iam.role_name
}
output "lb_id" {
  value = module.apache2_lb.lb_id
}
output "tg_arn" {
  value = module.apache2_lb.tg_arn
}

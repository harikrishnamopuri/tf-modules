output "asg_id" {
  value = aws_autoscaling_group.asg.*.id
}

output "asg_name" {
  value = aws_autoscaling_group.asg.*.name
}

output "alf_name" {
   value = aws_launch_configuration.aws_launch_conf[0].name
}

output "sg" {
  value = aws_security_group.sg.id
}


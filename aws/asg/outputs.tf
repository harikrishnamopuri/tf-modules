output "id" {
  value = aws_autoscaling_group.asg.*.id
}

output "name" {
  value = aws_autoscaling_group.asg.*.name
}

output "sg" {
  value = aws_security_group.sg.id
}


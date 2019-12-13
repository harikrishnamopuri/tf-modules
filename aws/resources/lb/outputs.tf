output "lb_id" {
  value = element(
    coalescelist(aws_lb.alb.*.id, aws_lb.nlb.*.id, aws_elb.clb.*.id),
    0,
  )
}

output "tg_arn" {
  value = element(
    coalescelist(
      aws_lb_target_group.alb.*.arn,
      aws_lb_target_group.nlb.*.arn,
      ["404"],
    ),
    0,
  )
}

output "sg_id" {
  value = aws_security_group.lb.*.id
}

output "dns" {
  value = element(
    coalescelist(
      aws_lb.alb.*.dns_name,
      aws_lb.nlb.*.dns_name,
      aws_elb.clb.*.dns_name,
    ),
    0,
  )
}

output "zone_id" {
  value = element(
    coalescelist(
      aws_lb.alb.*.zone_id,
      aws_lb.nlb.*.zone_id,
      aws_elb.clb.*.zone_id,
    ),
    0,
  )
}

output "lb_arn" {
  value = element(
    coalescelist(aws_lb.alb.*.arn, aws_lb.nlb.*.arn, aws_elb.clb.*.id),
    0,
  )
}



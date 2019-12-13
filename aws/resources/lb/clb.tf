resource "aws_elb" "clb" {
  count           = var.type == "clb" ? 1 : 0
  name            = replace(module.name.string, "_", "-")
  internal        = var.internal
  subnets         = var.subnets
  security_groups = [aws_security_group.lb[0].id]

  listener {
    instance_port      = var.listener_srv[count.index]["port"]
    instance_protocol  = lookup(var.listener_srv[count.index], "protocol", "TCP")
    lb_port            = var.listener_lb[count.index]["port"]
    lb_protocol        = lookup(var.listener_lb[count.index], "protocol", "TCP")
    ssl_certificate_id = lookup(var.listener_lb[count.index], "cert_arn", "")
  }

  health_check {
    healthy_threshold   = lookup(var.listener_srv[count.index], "healthy", 3)
    unhealthy_threshold = lookup(var.listener_srv[count.index], "unhealthy", 2)
    interval            = lookup(var.listener_srv[count.index], "interval", 15)
    timeout             = lookup(var.listener_srv[count.index], "timeout", 5)
    target              = "${lookup(var.listener_srv[count.index], "protocol", "TCP")}:${var.listener_srv[count.index]["port"]}"
  }

  cross_zone_load_balancing   = var.cross_zone_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.conn_drain
  connection_draining_timeout = var.conn_drain_timeout

  tags = {
    Name            = module.name.string
    env             = var.env
    terraform       = "true"
  }
}


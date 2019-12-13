resource "aws_lb" "alb" {
  count                      = var.type == "alb" ? 1 : 0
  name                       = replace(module.name.string, "_", "-")
  internal                   = var.internal
  load_balancer_type         = "application"
  enable_deletion_protection = var.del_protect
  subnets                    = var.subnets
  security_groups            = [aws_security_group.lb[0].id]
  idle_timeout               = var.idle_timeout

  lifecycle {
    ignore_changes = [name]
  }

  tags = {
    Name            = module.name.string
    env             = var.env
    terraform       = "true"
  }
}

resource "aws_lb_listener" "alb" {
  count             = var.type == "alb" ? length(var.listener_lb) : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = var.listener_lb[count.index]["port"]
  protocol          = lookup(var.listener_lb[count.index], "protocol", "") != "" ? "HTTPS" : "HTTP"
  ssl_policy        = lookup(var.listener_lb[count.index], "ssl_policy", "") != "" ? "ELBSecurityPolicy-2015-05" : ""
  certificate_arn   = lookup(var.listener_lb[count.index], "cert_arn", "")

  default_action {
    type = "forward"
    target_group_arn = element(
      aws_lb_target_group.alb.*.arn,
      index(
        aws_lb_target_group.alb.*.port,
        tonumber(var.listener_lb[count.index]["dest_port"]),
      ),
    )
  }
}

### target group
resource "aws_lb_target_group" "alb" {
  count    = var.type == "alb" ? length(var.listener_srv) : 0
  name     = "${replace(module.name.string, "_", "-")}${count.index}"
  port     = var.listener_srv[count.index]["port"]
  protocol = lookup(var.listener_srv[count.index], "protocol", "HTTP")
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = lookup(var.listener_srv[count.index], "healthy", 3)
    unhealthy_threshold = lookup(var.listener_srv[count.index], "unhealthy", 2)
    interval            = lookup(var.listener_srv[count.index], "interval", 15)
    timeout             = lookup(var.listener_srv[count.index], "timeout", 5)
    path                = lookup(var.listener_srv[count.index], "check_path", "/health")
    matcher             = lookup(var.listener_srv[count.index], "response_codes", "200")
    port = lookup(
      var.listener_srv[count.index],
      "healthcheck_port",
      "traffic-port",
    )
  }

  lifecycle {
    ignore_changes = [name]
  }

  stickiness {
    type    = "lb_cookie"
    enabled = var.stickiness
  }

  tags = {
    Name = "${module.name.string}${count.index}"
  }
}


resource "aws_lb" "nlb" {
  count                      = var.type == "nlb" ? 1 : 0
  name                       = replace(module.name.string, "_", "-")
  internal                   = var.internal
  load_balancer_type         = "network"
  enable_deletion_protection = var.del_protect
  subnets                    = var.subnets

  tags = {
    Name            = module.name.string
    env             = var.env
    terraform       = "true"
  }
}

resource "aws_lb_listener" "nlb" {
  count             = var.type == "nlb" ? length(var.listener_lb) : 0
  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.listener_lb[count.index]["port"]
  protocol          = lookup(var.listener_lb[count.index], "protocol", "TCP")

  default_action {
    type = "forward"
    target_group_arn = element(
      aws_lb_target_group.nlb.*.arn,
      index(
        aws_lb_target_group.nlb.*.port,
        tonumber(var.listener_lb[count.index]["dest_port"]),
      ),
    )
  }
}

### target group
resource "aws_lb_target_group" "nlb" {
  count    = var.type == "nlb" ? length(var.listener_srv) : 0
  name     = "${replace(module.name.string, "_", "-")}${count.index}"
  port     = var.listener_srv[count.index]["port"]
  protocol = lookup(var.listener_srv[count.index], "protocol", "TCP")
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold = lookup(var.listener_srv[count.index], "healthy", 3)
    interval          = lookup(var.listener_srv[count.index], "interval", 10)
    protocol          = lookup(var.listener_srv[count.index], "healthcheck_protocol", "TCP")
    port = lookup(
      var.listener_srv[count.index],
      "healthcheck_port",
      "traffic-port",
    )
  }

  lifecycle {
    ignore_changes = [name]
  }

  tags = {
    Name = "${module.name.string}${count.index}"
  }
}


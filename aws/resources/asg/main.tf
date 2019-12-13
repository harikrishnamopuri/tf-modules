###  Naming rule
module "frigga_app" {
  source = "../alias"
  string = replace(var.app_name, "-", "")
}

module "name" {
  source = "../alias"
  string = join(
    "-",
    compact(
      [
        module.frigga_app.string,
        var.env,
        var.region,
      ],
    ),
  )
}



resource "aws_security_group" "sg" {
  name   = "${module.name.string}-asg"
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  tags = {
    Name = "${module.name.string}-asg"
  }
}

resource "aws_security_group_rule" "cluster_ingress" {
  security_group_id = aws_security_group.sg.id
  from_port         = 0
  to_port           = 65535
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "opened all"
}

resource "aws_security_group_rule" "cluster_egress" {
  security_group_id = aws_security_group.sg.id
  from_port         = 0
  to_port           = 65535
  type              = "egress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "opened all"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_launch_configuration" "aws_launch_conf" {
  count     = var.aws_launch_conf == "true" ? 1 : 0
  user_data = "ls /home"
  name_prefix          = "${module.name.string}-"
  iam_instance_profile = var.instance_profile
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  security_groups = concat(var.extra_security_groups, [aws_security_group.sg.id])
  key_name        = var.ssh_key

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [image_id]
  }

  root_block_device {
    volume_type           = var.ebs_type
    volume_size           = var.ebs_size
    delete_on_termination = var.ebs_delete
  }
}

resource "random_id" "asg_id" {
  keepers = {
    env  = var.env
  }

  byte_length = 6
}


resource "aws_autoscaling_group" "asg" {
  count = var.autoscaling_group == "true" ? 1 : 0
  name  = "${module.name.string}-${random_id.asg_id.hex}"

  force_delete         = true
  vpc_zone_identifier  = var.private_subnets
  launch_configuration = aws_launch_configuration.aws_launch_conf[count.index].name

  max_size = var.max_size
  min_size = var.min_size

  health_check_grace_period = var.launch_time
  health_check_type         = var.health_check_type
  termination_policies      = var.termination_policies

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  tag {
    key                 = "Name"
    value               = module.name.string
    propagate_at_launch = "true"
  }
}

resource "aws_security_group" "lb" {
  count       = var.type != "nlb" ? 1 : 0
  name        = "${module.name.string}-lb"
  description = "${module.name.string} LB SG"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${module.name.string}-lb"
  }
}


# Application Load

resource "aws_alb" "front_end" {
  name            = "app-alb"
  internal        = false
  security_groups = ["${module.lb_nsg.nsg_id}"]
  subnets         = ["${var.public_subnets}"]

  enable_deletion_protection = false

  tags {
    Environment = "production"
  }
}


resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.front_end.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.ssl_cert_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.front_end.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "front_end" {
  name     = "app-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}


# LB NSG
module "lb_nsg" {
  source = "./nsg"

  name          = "app_alb"
  description   = "StreamCo Application ELB NSG"

  ingress_rules = ["${var.lb_ingress_rules}"]
  egress_rules  = ["${var.lb_egress_rules}"]
}

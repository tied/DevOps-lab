#Launch Configuration for AS group
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "app-server-"
  image_id      = "${var.ami}"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name      = "${var.key_name}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  lifecycle {
    create_before_destroy = true
  }

}

# Autoscaling Group
resource "aws_autoscaling_group" "as_group" {
  name                 = "app-server-as"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  min_size             = 3
  max_size             = 3

  health_check_grace_period = 300
  health_check_type         = "ELB"

  availability_zones   = "${var.availability_zones}"
  vpc_zone_identifier  = ["${aws_subnet.public.*.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

# App Server NSG
resource "aws_security_group" "app_server_nsg" {
  name        = "app_server_nsg"
  description = "App Server Network Security Group"
}

# Ingress Rules
resource "aws_security_group_rule" "ingress_rules" {
  count           = "${length(var.ingress_rules)}"
  type            = "ingress"
  protocol        = "${element(split(",", element(var.ingress_rules, count.index)), 0)}"
  from_port       = "${element(split(",", element(var.ingress_rules, count.index)), 1)}"
  to_port         = "${element(split(",", element(var.ingress_rules, count.index)), 2)}"
  cidr_blocks     = ["${element(split(",", element(var.ingress_rules, count.index)), 3)}"]

  security_group_id = "${aws_security_group.app_server_nsg.id}"
}

resource "aws_security_group_rule" "egress_rules" {
  count           = "${length(var.ingress_rules)}"
  type            = "egress"
  protocol        = "${element(split(",", element(var.ingress_rules, count.index)), 0)}"
  from_port       = "${element(split(",", element(var.ingress_rules, count.index)), 1)}"
  to_port         = "${element(split(",", element(var.ingress_rules, count.index)), 2)}"
  cidr_blocks     = ["${element(split(",", element(var.ingress_rules, count.index)), 3)}"]

  security_group_id = "${aws_security_group.app_server_nsg.id}"
}

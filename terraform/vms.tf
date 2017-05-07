
#Launch Configuration for AS group
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "app-server-"
  image_id      = "${var.app_ami}"
  instance_type = "${var.app_vm_size}"
  associate_public_ip_address = true
  key_name      = "${var.app_key_name}"
  security_groups = ["${module.app_nsg.nsg_id}"]

  user_data     = "${file("./userdata.sh")}"

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
  min_size             = 2
  max_size             = 2

  health_check_grace_period = 500
  health_check_type         = "ELB"

  availability_zones   = "${var.availability_zones}"
  vpc_zone_identifier  = ["${var.public_subnets}"]

  target_group_arns    = ["${aws_alb_target_group.front_end.id}"]

  lifecycle {
    create_before_destroy = true
  }
}


module "app_nsg" {
  source = "./nsg"

  name          = "app_ngs"
  description   = "StreamCo Application nsg"

  ingress_rules = ["${var.app_ingress_rules}"]
  egress_rules  = ["${var.app_egress_rules}"]

}

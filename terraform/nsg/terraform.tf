variable name {}
variable description {}
variable ingress_rules { default = [] }
variable egress_rules  { default = [] }

# Network Security Group
resource "aws_security_group" "app_server_nsg" {
  name        = "${var.name}"
  description = "${var.description}"
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

output nsg_id {
  value = "${aws_security_group.app_server_nsg.id}"
}

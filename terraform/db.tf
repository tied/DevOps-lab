# Database instance
resource "aws_db_instance" "default" {
  identifier             = "postgres"
  allocated_storage      = "100"
  engine                 = "postgres"
  engine_version         = "9.5.4"
  instance_class         = "db.t2.micro"
  name                   = "streamco_db"
  username               = "streamco_test"
  password               = "streamco!23"
  vpc_security_group_ids = ["${module.db_nsg.nsg_id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.default.id}"
  publicly_accessible    = true
}

resource "aws_db_subnet_group" "default" {
  name        = "app_db_subnetgroup"
  subnet_ids  = ["${var.private_subnets}"]
}

# LB NSG
module "db_nsg" {
  source = "./nsg"

  name          = "app_db_nsg"
  description   = "StreamCo Application ELB NSG"

  ingress_rules = ["${var.db_ingress_rules}"]
  egress_rules  = ["${var.db_egress_rules}"]
}

# route 53 record
resource "aws_route53_record" "db" {
  zone_id = "ZF0V6KEURF4LN"
  name    = "db.stan.rorychatterton.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_db_instance.default.address}"]
}

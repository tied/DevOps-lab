# Network Variables
variable vpc_id {}
variable private_subnets { default = [] }
variable public_subnets { default = [] }
variable availability_zones { default = [] }

# Availability Zone
variable app_vm_size { }
variable app_ami { }
variable app_key_name { }
variable app_egress_rules { default = [] }
variable app_ingress_rules { default = [] }

# LB Variables
variable ssl_cert_arn    { }
variable lb_egress_rules { default = [] }
variable lb_ingress_rules { default = [] }

# DB Variables
variable db_egress_rules { default = [] }
variable db_ingress_rules { default = [] }

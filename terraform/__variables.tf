variable cidr_block {
  default = "10.0.0.0/16"
}

variable private_subnets {
  default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable public_subnets {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable availability_zones {
  default = ["ap-southeast-2a","ap-southeast-2b","ap-southeast-2c"]
}

variable ami {
  default = "ami-96666ff5" // Ubuntu Zesty Instance Store
}

variable egress_rules {
  default = []
}

variable ingress_rules {
  default = ["tcp,22,22,0.0.0.0/24"]
}

variable key_name {
  default = "stan"
}

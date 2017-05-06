variable private_subnets {
  default = ["172.31.0.0/24", "172.31.1.0/24"]
}

variable public_subnets {
  default = ["172.31.10.0/24", "172.31.11.0/24"]
}

variable availability_zones {
  default = ["ap-southeast-1a","ap-southeast-1b",]
}

variable vpc_id {
  default = "vpc-9dbf1ff8"
}

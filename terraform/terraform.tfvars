# Network Variables
vpc_id             = "vpc-9dbf1ff8"
public_subnets     = ["subnet-6f604519", "subnet-633a0a07"]
private_subnets    = ["subnet-5f3b0b3b", "subnet-70614406"]
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

# VM Variables
app_vm_size        = "t2.micro"
app_ami            = "ami-8fcc75ec"
#app_egress_rules   =
app_ingress_rules  = ["tcp,22,22,0.0.0.0/24","tcp,8000,8000,0.0.0.0/24"]
app_key_name       = "stan2"

# LB Variables
#lb_egress_rules    =
lb_ingress_rules   = ["tcp,443,443,0.0.0.0/24",]
ssl_cert_arn       = "arn:aws:acm:ap-southeast-1:645872871318:certificate/fd4d7163-10c3-46aa-83bd-2efa494726f5"

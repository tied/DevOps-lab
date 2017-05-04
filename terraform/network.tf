## VPC Resource
resource "aws_vpc" "main" {
  cidr_block       = "${var.cidr_block}"
  instance_tenancy = "dedicated"

  tags {
    Name = "prod_vpc"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    subnet = "private"
    az = "${element(var.availability_zones, count.index)}"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.public_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    subnet = "public"
    az = "${element(var.availability_zones, count.index)}"
  }
}

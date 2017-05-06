# Private Subnets
resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"
  vpc_id     = "${var.vpc_id}"
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
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${element(var.public_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    subnet = "public"
    az = "${element(var.availability_zones, count.index)}"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = "${var.vpc_id}"
}

#Route from Public Subnets to IG
resource "aws_route_table" "r" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags {
    Name = "main"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.instanceTenancy
  enable_dns_support = var.dns_Support
  enable_dns_hostnames = var.dns_HostNames
  tags = {
    Name = format("%s-%s", var.name, "VPC")
  }
}

resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-%s", var.name, "IG")
  }
}

resource "aws_subnet" "public" {
  count = length(var.subnet_CIDR_Public)
  cidr_block = var.subnet_CIDR_Public[count.index]
  vpc_id = aws_vpc.vpc.id
  availability_zone = var.availabilityZone[count.index]
  map_public_ip_on_launch = var.map_PublicIP
  tags = {
    Name = format("%s-%s-%s-%s", "public", var.availabilityZone[count.index], var.name, "subnet")
  }
}

resource "aws_subnet" "private" {
  count = length(var.subnet_CIDR_Private)
  cidr_block = var.subnet_CIDR_Private[count.index]
  vpc_id = aws_vpc.vpc.id
  availability_zone = var.availabilityZone[count.index]
  tags = {
    Name = format("%s-%s-%s-%s", "private", var.availabilityZone[count.index], var.name, "subnet")
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-%s-%s", "private", var.name, "route")
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_internet
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    Name = format("%s-%s-%s", "public", var.name, "route")
  }
}

resource "aws_route_table_association" "vps_ass_pub" {
  count = length(var.subnet_CIDR_Public)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "vps_ass_private" {
  count = length(var.subnet_CIDR_Private)
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "web_sg" {
  name = format("%s-%s", var.name, "sg")
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-%s", var.name, "sg")
  }
}

resource "aws_security_group_rule" "ingress_ports" {
  count = length(var.allow_ports)
  from_port = element(var.allow_ports, count.index)
  protocol = var.protocol
  security_group_id = aws_security_group.web_sg.id
  to_port = element(var.allow_ports, count.index)
  type = "ingress"
  cidr_blocks = [
    var.host_CIDR_ip]
}

resource "aws_security_group_rule" "egress_ports" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.web_sg.id
  to_port = 0
  type = "egress"
  cidr_blocks = [
    var.cidr_internet]
}

variable "region" {}
variable "vpc_cidr" {}
variable "instanceTenancy" {}
variable "dns_Support" {}
variable "dns_HostNames" {}
variable "vpc_name" {}
variable "internet_gateway_name" {}
variable "availabilityZone" {}
variable "subnet_CIDR_Public" {}
variable "subnet_CIDR_Private" {}
variable "map_PublicIP" {}
variable "public_subnet_name" {}
variable "private_subnet_name" {}
variable "private_route_name" {}
variable "public_route_name" {}
variable "cidr_internet" {}
variable "security_group_name" {}
variable "allow_ports" {}
variable "protocol" {}
variable "host_CIDR_ip" {}


provider "aws" {
  region = var.region
  shared_credentials_file = "$HOME/.aws/config"
  profile = "admin"
}

resource "aws_vpc" "mine_vps" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.instanceTenancy
  enable_dns_support = var.dns_Support
  enable_dns_hostnames = var.dns_HostNames
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.mine_vps.id
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_subnet" "public" {
  count = length(var.subnet_CIDR_Public)
  cidr_block = var.subnet_CIDR_Public[count.index]
  vpc_id = aws_vpc.mine_vps.id
  availability_zone = var.availabilityZone[count.index]
  map_public_ip_on_launch = var.map_PublicIP
  tags = {
    Name = var.public_subnet_name[count.index]
  }
}

resource "aws_subnet" "private" {
  cidr_block = var.subnet_CIDR_Private
  vpc_id = aws_vpc.mine_vps.id
  availability_zone = element(var.availabilityZone, 0)
  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.mine_vps.id
  tags = {
    Name = var.private_route_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.mine_vps.id
  route {
    cidr_block = var.cidr_internet
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    Name = var.public_route_name
  }
}

resource "aws_route_table_association" "vps_ass_pub" {
  count = length(var.subnet_CIDR_Public)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "vps_ass_private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.mine_vps.id
  tags = {
    Name = var.security_group_name
  }
}

resource "aws_security_group_rule" "ingress_ports" {
  count = length(var.allow_ports)
  from_port = element(var.allow_ports, count.index)
  protocol = var.protocol
  security_group_id = aws_security_group.web_sg.id
  to_port = element(var.allow_ports, count.index)
  type = "ingress"
  cidr_blocks = [var.host_CIDR_ip]
}

resource "aws_security_group_rule" "egress_ports" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.web_sg.id
  to_port = 0
  type = "egress"
  cidr_blocks = [var.cidr_internet]
}

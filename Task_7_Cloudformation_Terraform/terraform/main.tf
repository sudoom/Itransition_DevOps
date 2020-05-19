provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = var.credentials_file
  profile = var.profile
}

provider "tls" {}

module "vpc" {
  source = "./modules/VPC"
  name = "Mossad"
  vpc_cidr = "10.10.0.0/16"
  availabilityZone = [
    "eu-central-1a",
    "eu-central-1b"]
  subnet_CIDR_Private = [
    "10.10.110.0/24"]
  subnet_CIDR_Public = [
    "10.10.100.0/24",
    "10.10.200.0/24"]
  allow_ports = [
    22,
    80,
    443]
  host_CIDR_ip = var.host_IP
}

output "VPC" {
  value = module.vpc
}

module "ec2" {
  source = "./modules/EC2"
  name = "Mossad"
  vpc_security_group_ids = module.vpc.security_group_id
  subnet_ids = module.vpc.vpc-publicsubnet-ids
  availability_zones = module.vpc.vpc_public_available_zones
}

output "EC2" {
  value = module.ec2
}

module "elb" {
  source = "./modules/ELB"
  name = "Mossad"
  security_groups = module.vpc.security_group_id
  subnets = module.vpc.vpc-publicsubnet-ids
  instances = module.ec2.instance_ids
  listener = [
    {
      instance_port = 80
      instance_protocol = "HTTP"
      lb_port = 80
      lb_protocol = "HTTP"
    },
    {
      instance_port = 443
      instance_protocol = "HTTP"
      lb_port = 443
      lb_protocol = "HTTP"
    }]
  health_check = {
    healthy_threshold = 2
    interval = 5
    target = "HTTP:80/"
    timeout = 2
    unhealthy_threshold = 2
  }

  allow_ports = [
    80,
    443]
}

output "ELB" {
  value = module.elb
}
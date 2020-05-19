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
  name_key = "Mossad_security_key"
}
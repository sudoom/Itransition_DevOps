terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = var.credentials_file
  profile = var.profile
}

module "vpc" {
  source = "../../modules/VPC"
  name = "Mossad"
  vpc_cidr = "10.10.0.0/16"
  availabilityZone = [
    "eu-central-1a",
    "eu-central-1b"]
  subnet_CIDR_Private = [
    "10.10.110.0/24",
    "10.10.120.0/24"]
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

module "elasticache" {
  source = "../../modules/ElastiCache "
  name = "mossad"
  security_groups_ids = module.vpc.security_group_id
  subnet_ids = module.vpc.vpc-privatesubnet-ids
  cidr_ec2 = module.vpc.vpc-publicsubnets
  node_type_redis = "t2.micro"
  node_type_memcached = "t2.micro"
  engine_version_redis = "5.0.6"
  engine_version_memcached = "1.5.16"
  num_cache_nodes_redis = 1
  num_cache_nodes_memcached = 1
}

output "ElastiCache" {
  value = module.elasticache
}
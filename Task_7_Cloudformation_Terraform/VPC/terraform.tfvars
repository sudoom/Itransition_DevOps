#####################################
# GENERAL
#####################################
region = "eu-central-1"

#####################################
# VPC
#####################################
vpc_cidr = "10.10.0.0/16"
instanceTenancy = "default"
dns_Support = "true"
dns_HostNames = "false"
vpc_name = "Mossad-VPC"

#####################################
# INTERNET GATEWAY
#####################################
internet_gateway_name = "Mossad-IG"

#####################################
# SUBNETS
#####################################
availabilityZone = [
  "eu-central-1a",
  "eu-central-1b"
]
subnet_CIDR_Public = [
  "10.10.100.0/24",
  "10.10.200.0/24"
]
subnet_CIDR_Private = "10.10.110.0/24"
map_PublicIP = "true"
public_subnet_name = [
  "pub-A-Mossad-subnet",
  "pub-B-Mossad-subnet"
]
private_subnet_name = "private-A-Mossad-subnet"

#####################################
# ROUTE TABLES
#####################################
private_route_name = "Private-Mossad-route"
public_route_name = "Public-Mossad-route"
cidr_internet = "0.0.0.0/0"

#####################################
# SECURITY GROUP
#####################################
security_group_name = "web_sg"
allow_ports = [
  22,
  80,
  443
]
protocol = "tcp"
host_CIDR_ip = "82.209.232.109/32"



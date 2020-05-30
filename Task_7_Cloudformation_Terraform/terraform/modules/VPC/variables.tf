#####################################
# MAIN
#####################################
variable "name" {
  default = ""
  type = string
}

#####################################
# VPC
#####################################
variable "vpc_cidr" {
  description = ""
  type = string
  default = ""
}
variable "instanceTenancy" {
  description = "(Optional) A tenancy option for instances launched into the VPC"
  type = string
  default = "default"
}
variable "dns_Support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type = bool
  default = true
}
variable "dns_HostNames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostname in the VPC. Defaults true."
  type = bool
  default = true
}

#####################################
# SUBNETS
#####################################
variable "availabilityZone" {
  default = []
  type = list(string)
  description = ""
}
variable "subnet_CIDR_Public" {
  default = []
  type = list(string)
  description = ""
}
variable "subnet_CIDR_Private" {
  default = []
  type = list(string)
  description = ""
}
variable "map_PublicIP" {
  default = true
  type = bool
  description = ""
}

#####################################
# ROUTE TABLES
#####################################
variable "cidr_internet" {
  default = "0.0.0.0/0"
  type = string
  description = ""
}

#####################################
# SECURITY GROUP
#####################################
variable "allow_ports" {
  default = []
  type = list(string)
  description = ""
}
variable "protocol" {
  default = "tcp"
  type = string
  description = ""
}
variable "host_CIDR_ip" {
  default = ""
  type = string
  description = ""
}

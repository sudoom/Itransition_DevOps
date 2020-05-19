#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default = ""
  type = string
}

variable "ami" {
  description = "I added only 3 regions to show the map feature but you can add all"
  type = string
  default = "ami-076431be05aaf8080"
}

variable "ec2_instance_type" {
  description = "Type of instance t2.micro, m1.xlarge, c1.medium etc"
  type = string
  default = "t2.micro"
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type = string
  default = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type = bool
  default = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type = bool
  default = false
}

variable "enable_associate_public_ip_address" {
  description = "Enabling associate public ip address (Associate a public ip address with an instance in a VPC)"
  type = bool
  default = true
}

variable "subnet_ids" {
  description = "Public subnet ID"
  type = list(string)
  default = []
}

variable "vpc_security_group_ids" {
  description = " SG for EC2"
  type = list(string)
  default = []
}

variable "availability_zones" {
  type = list(string)
  default = []
}

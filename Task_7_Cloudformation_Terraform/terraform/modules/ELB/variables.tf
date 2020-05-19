#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  type = string
  default = ""
}

# Create ELB

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB. Only valid if creating an ELB within a VPC"
  type = list(string)
  default = []
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type = list(string)
  default = []
}

variable "instances" {
  description = " Instances ID to add them to ELB"
  type = list(string)
  default = []
}

variable "elb_internal" {
  description = "If true, ELB will be an internal ELB"
  type = bool
  default = false
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing. Default: true"
  type = bool
  default = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Default: 60"
  type = string
  default = "60"
}

# Listener
variable "listener" {
  description = "A list of Listener block"
  type = list(map(string))

}

# Health Check
variable "health_check" {
  description = " Health check"
  type = map(string)

}

variable "connection_draining" {
  default = true
}

variable "cidr_internet" {
  default = "0.0.0.0/0"
  type = string
  description = ""
}

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

variable "name" {
  description = "Name to be used on all resources as prefix"
  default = ""
}

variable "engine_version_redis" {
  description = "The engine version to use."
  default = ""
  type = string
}

variable "engine_version_memcached" {
  description = "The engine version to use."
  default = ""
  type = string
}

variable "default_ports" {
  description = "Default cache ports"
  default = {
    memcached = "11211"
    redis = "6379"
  }
  type = map(string)
}
variable "subnet_ids" {
  description = "subnet IDs"
  type = list(string)
}

variable "security_groups_ids" {
  description = "sg IDs"
  type = list(string)
}

variable "protocol" {
  default = "tcp"
  type = string
}

variable "cidr_ec2" {
  default = []
  type = list(string)
  description = ""
}

variable "node_type" {
  default = "cache."
}

variable "node_type_redis" {
  default = ""
}

variable "node_type_memcached" {
  default = ""
}

variable "num_cache_nodes_redis" {
  default = 1
}

variable "num_cache_nodes_memcached" {
  default = 1
}
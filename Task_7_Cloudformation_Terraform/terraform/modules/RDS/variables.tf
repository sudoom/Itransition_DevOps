variable "name" {
  description = "Name to be used on all resources as prefix"
  default = ""
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes."
  type = number
  default = 20
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default = ""
  type = string
}

variable "engine" {
  description = "The database engine to use (mysql, postgres etc)"
  default = ""
  type = string
}

variable "engine_version" {
  description = "The engine version to use."
  default = ""
  type = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  default = ""
  type = string
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines."
  default = ""
  type = string
}

variable "db_username" {
  description = "Username for the master DB user."
  default = ""
  type = string
}

variable "db_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
  default = ""
  type = string
}

variable "default_ports" {
  description = "Default database ports"
  default = "5432"
  type = string
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

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  default = true
  type = bool
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default = false
  type = bool
}

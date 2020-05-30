resource "aws_db_instance" "db_instance" {
  identifier = format("%s-%s", var.name, "rds")
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  name = var.db_name
  username = var.db_username
  password = var.db_password
  port = var.default_ports
  skip_final_snapshot = var.skip_final_snapshot
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = var.security_groups_ids
  publicly_accessible = var.publicly_accessible
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = format("%s-%s", var.name, "subnet_db")
  subnet_ids = var.subnet_ids
  tags = {
    Name = format("%s-%s", var.name, "subnet_db")
  }
}

resource "aws_security_group_rule" "ingress_ports" {
  from_port = var.default_ports
  protocol = var.protocol
  security_group_id = element(var.security_groups_ids, 0)
  to_port = var.default_ports
  type = "ingress"
  cidr_blocks = var.cidr_ec2
}

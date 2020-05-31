resource "aws_elasticache_cluster" "memcached" {
  cluster_id = format("%s-%s", var.name, keys(var.default_ports)[0])
  engine = keys(var.default_ports)[0]
  engine_version = var.engine_version_memcached
  node_type = format("%s%s", var.node_type, var.node_type_memcached)
  num_cache_nodes = var.num_cache_nodes_memcached
  port = lookup(var.default_ports, keys(var.default_ports)[0])
  security_group_ids = var.security_groups_ids
  subnet_group_name = aws_elasticache_subnet_group.elasticache_subnet.name
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id = format("%s-%s", var.name, keys(var.default_ports)[1])
  engine = keys(var.default_ports)[1]
  engine_version = var.engine_version_redis
  node_type = format("%s%s", var.node_type, var.node_type_redis)
  num_cache_nodes = var.num_cache_nodes_redis
  port = lookup(var.default_ports, keys(var.default_ports)[1])
  security_group_ids = var.security_groups_ids
  subnet_group_name = aws_elasticache_subnet_group.elasticache_subnet.name
}

resource "aws_elasticache_subnet_group" "elasticache_subnet" {
  name = format("%s%s", var.name, "elasticachesubnet")
  subnet_ids = var.subnet_ids
}

resource "aws_security_group_rule" "ingress_ports" {
  count = length(values(var.default_ports))
  from_port = values(var.default_ports)[count.index]
  protocol = var.protocol
  security_group_id = var.security_groups_ids[0]
  to_port = values(var.default_ports)[count.index]
  type = "ingress"
  cidr_blocks = var.cidr_ec2
}

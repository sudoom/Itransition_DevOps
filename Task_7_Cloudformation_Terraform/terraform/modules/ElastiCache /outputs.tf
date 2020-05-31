output "elasticache_redis_ids" {
  value = aws_elasticache_cluster.redis.*.cluster_id
}

output "elasticache_redis_arn" {
  value = aws_elasticache_cluster.redis.*.arn
}

output "elasticache_redis_endpoint" {
  value = aws_elasticache_cluster.redis.*.cache_nodes
}

output "elasticache_memcached_ids" {
  value = aws_elasticache_cluster.memcached.*.cluster_id
}

output "elasticache_memcached_arn" {
  value = aws_elasticache_cluster.memcached.*.arn
}

output "elasticache_memcached_endpoint" {
  value = aws_elasticache_cluster.memcached.*.cache_nodes
}

output "elasticache_subnet_id" {
  value = aws_elasticache_subnet_group.elasticache_subnet.*.subnet_ids
}

output "elasticache_subnet_name" {
  value = aws_elasticache_subnet_group.elasticache_subnet.*.name
}

output "elasticache_security_group_id" {
  value = aws_security_group_rule.ingress_ports.*.security_group_id
}

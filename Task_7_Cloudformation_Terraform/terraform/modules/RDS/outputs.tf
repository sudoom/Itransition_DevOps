output "rds_ids" {
  value = aws_db_instance.db_instance.*.id
}

output "rds_arns" {
  value = aws_db_instance.db_instance.*.arn
}

output "rds_addresses" {
  value = aws_db_instance.db_instance.*.address
}

output "aws_db_subnet_group_ids" {
  value = aws_db_subnet_group.db_subnet_group.*.id
}

output "hosted_zone_ids" {
  value = aws_db_instance.db_instance.*.hosted_zone_id
}

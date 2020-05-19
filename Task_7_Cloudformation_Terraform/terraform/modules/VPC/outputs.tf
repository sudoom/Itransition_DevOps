output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "security_group_id" {
  value = [
    aws_security_group.web_sg.id]
}

output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "vpc-publicsubnets" {
  value = aws_subnet.public.*.cidr_block
}

output "vpc-publicsubnet-ids" {
  value = aws_subnet.public.*.id
}

output "vpc-privatesubnets" {
  value = aws_subnet.private.*.cidr_block
}

output "vpc-privatesubnet-ids" {
  value = aws_subnet.private.*.id
}

output "vpc_public_available_zones" {
  value = aws_subnet.public.*.availability_zone
}

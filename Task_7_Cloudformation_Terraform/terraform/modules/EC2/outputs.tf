# Output the IDs of the EC2 instances created
output "instance_ids" {
  value = aws_instance.instance.*.id
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value = aws_instance.instance.*.availability_zone
}

output "key_name" {
  description = "List of key names of instances"
  value = aws_instance.instance.*.key_name
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value = aws_instance.instance.*.public_ip
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value = aws_instance.instance.*.primary_network_interface_id
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value = aws_instance.instance.*.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value = aws_instance.instance.*.private_ip
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value = flatten(aws_instance.instance.*.vpc_security_group_ids)
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value = aws_instance.instance.*.subnet_id
}

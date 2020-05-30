resource "tls_private_key" "PK" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name = format("%s-%s", var.name, "security_key" )
  public_key = tls_private_key.PK.public_key_openssh
}

resource "aws_instance" "instance" {
  count = length(var.subnet_ids)
  ami = var.ami
  instance_type = var.ec2_instance_type
  tenancy = var.tenancy
  disable_api_termination = var.disable_api_termination
  ebs_optimized = var.ebs_optimized
  associate_public_ip_address = var.enable_associate_public_ip_address
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_ids[count.index]
  availability_zone = var.availability_zones[count.index]
  key_name = aws_key_pair.key_pair.key_name
  tags = {
    Name = format("%s-%s-%s-%s", "public", var.availability_zones[count.index], var.name, "instance")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      private_key = tls_private_key.PK.private_key_pem
    }
  }
}

resource "local_file" "local_private_key" {
  sensitive_content = tls_private_key.PK.private_key_pem
  filename = format("%s-%s", var.name, "security_key.pem" )
  file_permission = "0400"
}
terraform {
  required_version = "> 0.12.12"
}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = var.credentials_file
  profile = var.profile
}

provider "tls" {}


module "ec2" {
  source = "../../modules/EC2"
  name = "Mossad"
  ami = "ami-076431be05aaf8080"
  ec2_instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-0f26ae7ad20be3737"
  ]
  subnet_ids = [
    "subnet-05078311cf6b35c3f",
    "subnet-0dca7d0908ba80d38"
  ]
  availability_zones = [
    "eu-central-1a",
    "eu-central-1b"
  ]
}
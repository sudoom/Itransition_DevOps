terraform {
  required_version = "> 0.9.0"
}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = var.credentials_file
  profile = var.profile
}

module "elb" {
  source = "../../modules/ELB"
  name = "Mossad"
  security_groups = [
    "sg-0911ea431837ef3ed",
  ]
  subnets = [
    "subnet-047a20c75e30e38d3",
    "subnet-0821bd88755f4e4e9",
  ]
  instances = [
    "i-0550a214c9e9a692b",
    "i-01d472f5070966f31",
  ]
  listener = [
    {
      instance_port = 80
      instance_protocol = "HTTP"
      lb_port = 80
      lb_protocol = "HTTP"
    },
    {
      instance_port = 443
      instance_protocol = "HTTP"
      lb_port = 443
      lb_protocol = "HTTP"
    }]
  health_check = {
    healthy_threshold = 2
    interval = 5
    target = "HTTP:80/"
    timeout = 2
    unhealthy_threshold = 2
  }

  allow_ports = [
    80,
    443]
}

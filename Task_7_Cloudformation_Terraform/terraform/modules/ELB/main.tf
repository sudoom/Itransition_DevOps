#---------------------------------------------------
# Create AWS ELB
#---------------------------------------------------
resource "aws_elb" "elb" {
  name = format("%s-%s", var.name, "elb")
  subnets = var.subnets
  security_groups = var.security_groups
  internal = var.elb_internal
  cross_zone_load_balancing = var.cross_zone_load_balancing
  idle_timeout = var.idle_timeout
  connection_draining = var.connection_draining

  dynamic "listener" {
    for_each = var.listener
    content {
      instance_port = listener.value.instance_port
      instance_protocol = listener.value.instance_protocol
      lb_port = listener.value.lb_port
      lb_protocol = listener.value.lb_protocol
      ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
    }
  }

  health_check {
    healthy_threshold = lookup(var.health_check, "healthy_threshold")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    target = lookup(var.health_check, "target")
    interval = lookup(var.health_check, "interval")
    timeout = lookup(var.health_check, "timeout")
  }


  tags = {
    Name = format("%s-%s", var.name, "elb")
  }
}

resource "aws_elb_attachment" "elb_instances" {
  count = length(var.instances)
  elb = aws_elb.elb.name
  instance = element(var.instances, count.index )
}


resource "aws_security_group_rule" "ingress_ports" {
  count = length(var.allow_ports)
  from_port = element(var.allow_ports, count.index)
  protocol = var.protocol
  security_group_id = element(var.security_groups, 0)
  to_port = element(var.allow_ports, count.index)
  type = "ingress"
  cidr_blocks = [
    var.cidr_internet]
}

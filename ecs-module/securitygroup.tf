
# create security group for the service

resource "aws_security_group" "ecs_service_sg" {
  name_prefix = "${var.servicename}-sg"
  vpc_id      = var.vpc_id

## Allow traffic from the load balancer group 
  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.alb-sg-id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

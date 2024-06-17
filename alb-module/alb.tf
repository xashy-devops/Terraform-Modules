#Create the load balancer security group. 
resource "aws_security_group" "lb_sg" {

    name_prefix = "${var.lb_name}-sg"
    vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

}

}

# create the load balancer 
resource "aws_lb" "alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets

  tags = var.lbtags
}

# create a target group for the service on ecs 
resource "aws_lb_target_group" "service-tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 1
    unhealthy_threshold = 5
    matcher             = "200"
  }
}

# Create a listener that listens to traffic. 
resource "aws_lb_listener" "service-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listenerport
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service-tg.arn
  }
}


#########################################################################################

#VPC
resource "aws_vpc" "app_vpc" {
    cidr_block = var.vpc_cidr
}

#Subnets
resource "aws_subnet" "app_subnets" {

  count = length(var.subnet_cidr)

  vpc_id     = aws_vpc.app_vpc.id
  availability_zone = var.subnet_AZs[count.index]
  cidr_block = var.subnet_cidr[count.index]
}

#IGW
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
}



#alb security group
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "whitelists https inbound and outbound traffics"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    # security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}



#ALB
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets = [for subnet in aws_subnet.app_subnets: subnet.id]

  enable_deletion_protection = false
}

#Target group
resource "aws_lb_target_group" "app_alb_tg" {
  name       = "tg"
  port       = 80
  protocol   = "HTTP"
  depends_on = [aws_vpc.app_vpc]
  vpc_id     = aws_vpc.app_vpc.id

  health_check {
    interval            = 70
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
  }
}

#ALB port 80 listener
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_alb_tg.arn
  }
}


output "load_balancer_arn" {
  value       = aws_lb.alb.arn
  description = "The ARN of the load balancer."
}

output "target_group_arn" {
  value       = aws_lb_target_group.service-tg.arn
  description = "The ARN of the target group."
}

output "lb_sg_id" {
  value       = aws_security_group.lb_sg.id
  description = "The security group ID of the load balancer."
}

output "lb_sg_arn" {
  value       = aws_security_group.lb_sg.arn
  description = "The security group arn of the load balancer."
}


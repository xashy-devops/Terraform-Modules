variable "lb_name" {
  type        = string
  description = "The name of the load balancer."
}


variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the load balancer."
}

variable "target_group_name" {
  type        = string
  description = "The name of the target group."
}

variable "target_group_port" {
  type        = number
  description = "The port on which the target group is listening."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the target group is created."
}

variable "health_check_path" {
  type        = string
  description = "The path for the health check endpoint."
}

variable "lbtags" {
  type        = map(string)
  description = "A map of tags to assign to the resources."
}

variable "listenerport" {
  description = "port on which listener listens to incoming request"
  type = string
}

### ecs cluster variables
variable "clustername" {
  description = "name of the cluster"
  type = string
}

# variable "lbname" {
#   type = string
# }

## Task definition variables

variable "task_family" {
  description = "Name of the task family"
  type = string 
}

variable "cpu" {
  type        = string
  description = "The number of CPU units used by the task."
}

variable "memory" {
  type        = string
  description = "The amount of memory (in MiB) used by the task."
}

variable "container_cpu" {
  description = "cpu size to be alloacted to the task"
  type = number 
}


variable "container_image" {
  description = "name of the container image"
  type = string
}

variable "container_memory" {
  type        = number
  description = "The amount of memory (in MiB) reserved for the container."
}

variable "container_port" {
  type        = number
  description = "The port number on the container that is bound to the host port."
}

variable "region" {
  description = "Name of the region for the cluster"
  type = string
}

variable "container_name" {
  description = "name of the container "
  type = string
}


## variables for the service. 
variable "servicename" {
  description = "Then name of the service"
  type = string
}

variable "taskcount" {
  description = "the number of pods that should be created "
  type = number 
}

variable "subnets" {
  description = "the list of subnets"
  type = list(string)

}

variable "target_group_arn" {
  description = "The target group arn"
  type = string 
}

variable "vpc_id" {
  description = "The id of the vpc"
  type = string
}

variable "alb-sg-id" {
  description = "The ids of the load balancer security group"
  # type = list(string)
}

variable "ecsexecutionrole" {
  description = "task execution role"
  type = string
}
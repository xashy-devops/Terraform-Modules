## output the cluster arn 

output "clusterarn" {
    description = "Output the cluster arn"
    value = aws_ecs_cluster.mycluster.arn
}

## output the cluster id

output "clusterid" {
    description = "Output the cluster arn"
    value = aws_ecs_cluster.mycluster.id
}

output "serviceid" {
  description = "id of the service"
  value = aws_ecs_service.ecs-service.id
}

output "security-group-id" {
  description = "id of the security group"
  value = aws_security_group.ecs_service_sg.id
}

output "taskdef_arn" {
  description = "arn of task definition"
  value = aws_ecs_task_definition.taskdef.arn
}
# output "taskdef_arn" {
#   description = "arn of task definition"
#   value = aws_ecs_task_definition.taskdef.
# }
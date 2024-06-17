resource "aws_ecs_service" "ecs-service" {
  name            = var.servicename
  cluster         = aws_ecs_cluster.mycluster.id
  task_definition = aws_ecs_task_definition.taskdef.arn
  desired_count   = var.taskcount
  launch_type = "FARGATE"
  wait_for_steady_state = true



  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }


  load_balancer {
  
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
}


depends_on = [ aws_ecs_task_definition.taskdef ]

}
resource "aws_ecs_service" "ecs-service" {
  name            = var.servicename
  cluster         = aws_ecs_cluster.mycluster.id
  task_definition = aws_ecs_task_definition.taskdef.arn
  desired_count   = var.taskcount
  launch_type = "FARGATE"
  wait_for_steady_state = true

  lifecycle {
    ignore_changes = [ desired_count ]
  }



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

## add autoscaling for the service using app autoscaling.name

resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.mycluster.name}/${aws_ecs_service.ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_capacity # Minimum number of tasks
  max_capacity       = var.max_capacity # Maximum number of tasks

}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "${var.servicename}-autoscaling-policy"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.mycluster.name}/${aws_ecs_service.ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  policy_type = "TargetTrackingScaling"

  # Target tracking scaling policy (Example - adjust as needed)
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70 # Target average CPU utilization
  }

  depends_on = [ aws_appautoscaling_target.ecs_target ]
}

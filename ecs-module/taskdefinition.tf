#create a log group for the task to publish logs into clludwatch logs 

resource "aws_cloudwatch_log_group" "taskloggroup" {
  name = "${var.task_family}-loggroup"
}


#create task execution role. 
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.task_family}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# #attach a policy to the role .
resource "aws_iam_policy_attachment" "ecs_task_execution_policy" {
  name       = "ecs_task_execution_policy"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# create a task defiition and specifiy the necessary configurations. 
resource "aws_ecs_task_definition" "taskdef" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn


  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.taskloggroup.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}





# create ECS cluster
resource "aws_ecs_cluster" "mycluster" {
    name = var.clustername

    setting {
      name = "containerInsights"
      value = "enabled"
    }
        
}







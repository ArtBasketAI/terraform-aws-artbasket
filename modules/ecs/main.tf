resource "aws_ecs_task_definition" "artbasket_task" {
  family                   = "artbasket-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode([{
    name  = "artbasket-container",
    image = "bharathts07/artbasket-frontend",
    portMappings = [{
      containerPort = 3000,
      hostPort      = 3000
    }]
  }])
}

resource "aws_ecs_service" "artbasket_service" {
  name            = "artbasket-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.artbasket_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
  }
}

resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-api-task"
  container_definitions    = jsonencode([{
    name      = "my-api-container"
    image     = "${aws_ecr_repository.my_repository.repository_url}:latest"
    cpu       = 256
    memory    = 512
    portMappings = [{
      containerPort = 8080
      protocol      = "tcp"
    }]
  }])

  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "my_service" {
  name            = "my-api-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = var.ecs_desired_capacity
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]  # Update with your subnet IDs
    assign_public_ip = true
    security_groups = ["sg-xxxxxxxx"]  # Update with your security group IDs
  }
}

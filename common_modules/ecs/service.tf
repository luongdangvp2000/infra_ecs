# Services
resource "aws_ecs_service" "ecs_service_be" {
  name            = var.ecs_service.name[0]
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition_be.arn
  desired_count   = var.ecs_service.desired_count
  launch_type     = var.ecs_service.launch_type

  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn_be
    container_name   = var.containers["be"].container_name
    container_port   = var.containers["be"].container_port
  }
}

resource "aws_ecs_service" "ecs_service_fe" {
  name            = var.ecs_service.name[1]
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition_fe.arn
  desired_count   = var.ecs_service.desired_count
  launch_type     = var.ecs_service.launch_type

  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn_fe
    container_name   = var.containers["fe"].container_name
    container_port   = var.containers["fe"].container_port
  }
}


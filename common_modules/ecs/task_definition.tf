# Task definition
resource "aws_ecs_task_definition" "ecs_task_definition_be" {
  family                   = var.ecs_task_definition.family[0]
  network_mode             = var.ecs_task_definition.network_mode
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.ecs_task_definition.cpu
  memory                   = var.ecs_task_definition.memory
  requires_compatibilities = var.ecs_task_definition.requires_compatibilities

  container_definitions = file("task_definitions_json/task_definitions_be.json")

}

resource "aws_ecs_task_definition" "ecs_task_definition_fe" {
  family                   = var.ecs_task_definition.family[1]
  network_mode             = var.ecs_task_definition.network_mode
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.ecs_task_definition.cpu
  memory                   = var.ecs_task_definition.memory
  requires_compatibilities = var.ecs_task_definition.requires_compatibilities

  container_definitions = file("task_definitions_json/task_definitions_fe.json")

}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_cluster.name}-ecsTaskExecutionRole"

  assume_role_policy = <<EOF
	{
		"Version": "2012-10-17",
		"Statement": [
			{
				"Sid": "",
				"Effect": "Allow",
				"Principal": {
					"Service": "ecs-tasks.amazonaws.com"
				},
				"Action": "sts:AssumeRole"
			}
		]
	}
	EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
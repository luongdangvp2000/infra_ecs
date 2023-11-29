# variables for vpc module
vpc = {
  cidr_block_vpc       = "10.0.0.0/16",
  enable_dns_hostnames = true,
  nat_eip              = true,
  cidr_block_route     = "0.0.0.0/0",
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
  nat_subnet           = 0,
  env                  = "sit"
}

sg = {
  name        = "sg",
  description = "Open for all ports",
  # create_before_destroy = true,
  ingress = [
    {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
  ],

  egress = [{
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }],
  env = "sit"
}

# variables for alb module
ecs_alb_be = {
  name               = "ecs-alb-be",
  internal           = false,
  load_balancer_type = "application"
}

ecs_alb_fe = {
  name               = "ecs-alb-fe",
  internal           = false,
  load_balancer_type = "application"
}

ecs_alb_listener = {
  port     = 80,
  protocol = "HTTP",
  type     = "forward"
}

ecs_tg = {
  # name        = "ecs-target-group",
  port        = 80,
  protocol    = "HTTP",
  target_type = "ip",
  path        = "/"
}

# variables for ecs module
ecs_cluster = {
  name = "ecs-cluster"
}

ecs_task_definition = {
  family                   = ["ecs-task-be", "ecs-task-fe"]
  network_mode             = "awsvpc",
  cpu                      = 512,
  memory                   = 1024,
  requires_compatibilities = ["FARGATE"],

  # container_name = "express-app",
  # container_image = "331040559991.dkr.ecr.ap-southeast-1.amazonaws.com/express-app:latest",
  # container_cpu = 256,
  # container_memory = 512,
  # container_port = 5000,
}

ecs_service = {
  name          = ["ecs-service-be", "ecs-service-fe"]
  desired_count = 1,
  launch_type   = "FARGATE",
  # load_balancer = [
  #   {
  #     container_name = "express-app",
  #     container_port = 5000
  #   },
  #   {
  #     container_name = "react-app",
  #     container_port = 3000
  #   },
  # ],

  # container_name = "express-app",
  # container_port = 5000
  # container_name = "react-app",
  # container_port = 3000
}
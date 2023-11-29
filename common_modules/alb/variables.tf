variable "ecs_alb" {
  type = object({
    name               = string,
    internal           = bool,
    load_balancer_type = string,
  })

  # default = {
  #   name = "ecs-alb",
  #   internal = false,
  #   load_balancer_type = "application"
  # }
}

variable "ecs_alb_listener" {
  type = object({
    port     = number,
    protocol = string,
    type     = string,
  })

  # default = {
  #   port = 80,
  #   protocol = "HTTP",
  #   type = "forward"
  # }
}

variable "ecs_tg" {
  type = object({
    port        = number,
    protocol    = string,
    target_type = string,
    path        = string,
  })

  # default = {
  #   name        = "ecs-target-group",
  #   port        = 3000,
  #   protocol    = "HTTP",
  #   target_type = "ip",
  #   path = "/"
  # }
}

variable "security_group" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "vpc" {
  type = string
}


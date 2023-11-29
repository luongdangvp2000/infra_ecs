# variables for vpc module
variable "vpc" {
  description = "variables for vpc module"
}

variable "sg" {
  description = "variables for security group"
}

# variables for alb module
variable "ecs_alb_be" {
  description = "variables for alb"
}

variable "ecs_alb_fe" {
  description = "variables for alb"
}

variable "ecs_alb_listener" {
  description = "variables for alb listener"
}

variable "ecs_tg" {
  description = "variables for ecs target group"
}


# variables for ecs module
variable "ecs_cluster" {
  description = "variables for ecs cluster"
}

variable "ecs_task_definition" {
  description = "variables for ecs task definition"
}

variable "ecs_service" {
  description = "variables for ecs service"
}

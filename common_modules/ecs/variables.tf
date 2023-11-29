variable "ecs_cluster" {
  type = object({
    name = string,
  })

}

variable "ecs_task_definition" {
  type = object({
    family                   = list(string),
    network_mode             = string,
    cpu                      = number,
    requires_compatibilities = list(string),
    memory                   = number,
  })
}

variable "ecs_service" {
  type = object({
    name          = list(string),
    desired_count = number,
    launch_type   = string,
    # load_balancer = list(object({
    #   container_name = string,
    #   container_port = number
    # }))
    # container_name = string,
    # container_port = number
  })
}

variable "containers" {
  type = map(object({
    container_name = string,
    container_port = number,
  }))

  default = {
    "be" = {
      container_name = "express-app",
      container_port = 5000
    },

    "fe" = {
      container_name = "react-app",
      container_port = 3000
    }
  }
}

variable "subnets" {
  type = list(string)
}

variable "security_group" {
  type = string
}

variable "target_group_arn_fe" {
  type = string
}

variable "target_group_arn_be" {
  type = string
}
resource "aws_lb" "ecs_alb" {
  name               = var.ecs_alb.name
  internal           = var.ecs_alb.internal
  load_balancer_type = var.ecs_alb.load_balancer_type
  security_groups    = [var.security_group]
  subnets            = var.subnets

}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = var.ecs_alb_listener.port
  protocol          = var.ecs_alb_listener.protocol

  default_action {
    type             = var.ecs_alb_listener.type
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.ecs_alb.name}-tg"
  port        = var.ecs_tg.port
  protocol    = var.ecs_tg.protocol
  target_type = var.ecs_tg.target_type
  vpc_id      = var.vpc

  health_check {
    path = var.ecs_tg.path
  }
}
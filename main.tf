module "vpc" {
  source = "./common_modules/vpc"
  vpc    = var.vpc
  sg     = var.sg
}

module "alb_be" {
  source           = "./common_modules/alb"
  ecs_alb          = var.ecs_alb_be
  ecs_alb_listener = var.ecs_alb_listener
  ecs_tg           = var.ecs_tg
  security_group   = module.vpc.security_group_id
  subnets          = module.vpc.public_subnets_id
  vpc              = module.vpc.vpc_id
}

module "alb_fe" {
  source           = "./common_modules/alb"
  ecs_alb          = var.ecs_alb_fe
  ecs_alb_listener = var.ecs_alb_listener
  ecs_tg           = var.ecs_tg
  security_group   = module.vpc.security_group_id
  subnets          = module.vpc.public_subnets_id
  vpc              = module.vpc.vpc_id
}

module "ecs" {
  source              = "./common_modules/ecs"
  ecs_cluster         = var.ecs_cluster
  ecs_task_definition = var.ecs_task_definition
  ecs_service         = var.ecs_service
  security_group      = module.vpc.security_group_id
  subnets             = module.vpc.public_subnets_id
  target_group_arn_fe = module.alb_fe.ecs_tg_arn
  target_group_arn_be = module.alb_be.ecs_tg_arn
}

module "clw" {
  source = "./common_modules/clw"

}
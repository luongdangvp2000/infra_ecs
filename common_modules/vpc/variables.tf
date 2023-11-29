variable "vpc" {
  type = object({
    cidr_block_vpc       = string,
    enable_dns_hostnames = bool,
    nat_eip              = bool,
    cidr_block_route     = string,
    public_subnets       = list(string),
    private_subnets      = list(string),
    availability_zones   = list(string),
    nat_subnet           = number,

    env = string,
  })
}

variable "sg" {
  type = object({
    name        = string,
    description = string,
    # create_before_destroy = bool,
    ingress = list(object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    })),

    egress = list(object({
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    })),
    env = string
  })
}
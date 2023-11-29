output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnets[*].id
}

output "subnets_id" {
  value = concat(aws_subnet.public_subnets[*].id, aws_subnet.private_subnets[*].id)
}

output "security_group_id" {
  value = aws_security_group.sg.id
}
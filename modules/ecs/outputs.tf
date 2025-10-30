output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

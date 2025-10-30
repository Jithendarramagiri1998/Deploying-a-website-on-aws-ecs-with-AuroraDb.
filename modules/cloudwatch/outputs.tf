output "log_group_name" {
  description = "ECS Log Group Name"
  value       = aws_cloudwatch_log_group.ecs.name
}

output "dashboard_name" {
  description = "CloudWatch Dashboard Name"
  value       = aws_cloudwatch_dashboard.ecs_aurora_dashboard.dashboard_name
}

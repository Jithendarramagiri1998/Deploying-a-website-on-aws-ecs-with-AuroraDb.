# modules/aurora/outputs.tf

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}

output "aurora_sg_id" {
  value = aws_security_group.aurora_sg.id
}

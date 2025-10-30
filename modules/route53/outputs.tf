output "record_fqdn" {
  description = "Fully qualified domain name of environment"
  value       = aws_route53_record.env_record.fqdn
}

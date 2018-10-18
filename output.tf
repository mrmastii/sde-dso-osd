output "dns_name" {
  description = "The DNS Name"
  value       = "${aws_route53_record.www.fqdn}"
}

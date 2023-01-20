output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "My_webServer_sg_id" {
  description = "SG id of the EC2 instance"
  value       = aws_security_group.My_webServer.id
}

output "My_webServer_sg_arn" {
  description = "ARN SG of the EC2 instance"
  value       = aws_security_group.My_webServer.arn
}

output "My_webServer_sg_ingress" {
  description = "Ingress SG of the EC2 instance"
  value       = aws_security_group.My_webServer.ingress
}


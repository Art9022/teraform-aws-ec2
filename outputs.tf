output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "ec2_instance_name" {
  description = "Name of ec2 instance"
  value = "${var.name}_instance"
}

output "VPC" {
  description = "VPC name"
  value = "${var.name}_vpc"
}

output "VPC_id" {
  description = "VPC ID"
  value = aws_vpc.frst_vpc.id
  
}

output "aws_internet_gateway" {
  description = "Name of aws internet gateway"
  value = "${var.name}_aws_internet_gateway"
  
}

output "ID_aws_internet_gateway" {
  description = "ID of aws_internet_gateway"
  value = aws_internet_gateway.gw.id
  
}

output "aws_subnet" {
  description = "Name of aws subnet"
  value = "${var.name}_aws_subnet"
  
}

output "aws_subnet_ID" {
  description = "ID of aws subnet"
  value = aws_security_group.My_sg.id
  
}

output "aws_security_grup_name" {
  description = "aws security grup name"
  value = "${var.name}_security_grup"
  
}

output "aws_security_grup" {
  description = "aws security grup id"
  value = aws_security_group.My_sg.id
  
}


output "aws_network_interface_name" {
  description = "aws network interface name"
  value = "${var.name}_network_interface"
  
}

output "aws_network_interface_id" {
  description = "aws network interface ID"
  value = aws_network_interface.interface_0.id
  
}

output "web-address" {
  value = "${aws_instance.app_server.public_dns}:80"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

  

resource "aws_vpc" "frst_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "frst_subnet" {
  vpc_id     = aws_vpc.frst_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_network_interface" "interface_0" {
  subnet_id = aws_subnet.frst_subnet.id
  private_ips = ["10.0.1.10"]

  attachment {
    instance = aws_instance.app_server.id
    device_index = 1
  }

}

resource "aws_security_group" "My_sg" {
  name        = "My_sg"
  description = "SG for ec2"
  vpc_id      = aws_vpc.frst_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
}

resource "aws_security_group_rule" "allow_all_outbound" {
    type                 = "egress"
    from_port            = 80
    to_port              = 80
    protocol             = "-1"
    cidr_blocks          = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.My_sg.id

  
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  user_data = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.My_sg.id]
  subnet_id = aws_subnet.frst_subnet.id
  
  tags = {
    "name" = var.name
  }
}


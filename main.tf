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
}

resource "aws_network_interface" "interface_0" {
  subnet_id = aws_subnet.frst_subnet.id
  private_ips = ["10.0.1.10"]

}

resource "aws_security_group" "My_sg" {
  name        = var.name
  description = "SG for ec2"
  vpc_id      = aws_vpc.frst_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  user_data = file("user_data.sh")
  security_groups = [aws_security_group.My_sg.name]
  network_interface {
    network_interface_id = aws_network_interface.interface_0.id
    device_index = 1
  }
  
  tags = {
    "name" = var.name
  }
}

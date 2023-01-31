
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "artur_ayvazyan"

    workspaces {
      name = "migrate_terraform_cloud"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "frst_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.name}_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.frst_vpc.id

  tags = {
    Name = "${var.name}_aws_internet_gateway"
  }
}

resource "aws_route_table" "first_route_table" { 
  vpc_id = aws_vpc.frst_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.name}_route_table"
  }
}

resource "aws_subnet" "frst_subnet" {
  vpc_id     = aws_vpc.frst_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.name}_publik_subnet"
  }
}

resource "aws_route_table_association" "a" { 
  subnet_id      = aws_subnet.frst_subnet.id
  route_table_id = aws_route_table.first_route_table.id
}

resource "aws_security_group" "My_sg" {
  name        = "${var.name}_security_grup"
  description = "SG for ec2"
  vpc_id      = aws_vpc.frst_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
   tags = {
    Name = "${var.name}_security_grup"
   }

}

resource "aws_network_interface" "interface_0" {
  subnet_id = aws_subnet.frst_subnet.id
  security_groups = [aws_security_group.My_sg.id]
  private_ips = ["10.0.1.10"]


  attachment {
    instance = aws_instance.app_server.id
    device_index = 1
  }
 
}


resource "aws_instance" "app_server" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  user_data = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.My_sg.id]
  subnet_id = aws_subnet.frst_subnet.id
  depends_on = [aws_internet_gateway.gw]
  
  tags = {
    Name = "${var.name}_instance"
  }    

}


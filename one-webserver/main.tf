terraform {
  # Terraform 버전 지정
  required_version = ">= 1.0.0, < 2.0.0"

  # 공급자 지정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region = "ap-northeast-2"
}


resource "aws_instance" "example" {
  ami                    = "ami-06eea3cd85e2db8ce"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p $[var.server_port] &
              EOF

  tags = {
    Name = "aws16-terraform-example"
  }
}



resource "aws_security_group" "instance" {
  name = "aws16-terraform-example-instance"

  ingress {
    from_port   = var.server_port # 출발 포트
    to_port     = var.server_port # 도착 포트
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Public IP Output
output "public-ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}




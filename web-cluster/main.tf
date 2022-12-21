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


# 시작 구성 설정
resource "aws_launch_configuration" "example" {
  image_id        = "ami-06eea3cd85e2db8ce"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  key_name = "aws16-key"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  lifecycle {
    create_before_destroy = true
  }

}


# 오토스케일링 그룹
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier = data.aws_subnets.default.ids

  min_size = 1
  max_size = 2

  tag {
    key                 = "Name"
    value               = "aws16-terraform-asg-example"
    propagate_at_launch = true
  }
}


# 보안 그룹 설정
resource "aws_security_group" "instance" {
  name = "aws16-terraform-example-instance"

  ingress {
    from_port   = var.server_port # 출발 포트
    to_port     = var.server_port # 도착 포트
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# 디폴트 VPC 정보 가지고 오기
data "aws_vpc" "default" {
  default = true
}


# 서브넷 정보 가지고 오기
data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

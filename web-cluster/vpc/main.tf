provider "aws" {
  region = "ap-northeast-2"
}


data "aws_vpc" "default" {
  default = true
}


output "vpc-id" {
  value = data.aws_vpc.default.id
}

output "vpc-cidr_block" {
  value = data.aws_vpc.default.cidr_block
}

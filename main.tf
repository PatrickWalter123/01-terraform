provider "aws" {
  region = "ap-northeast-2"
}


variable "user_names" {
  description = "이 이름들로 IAM유저들을 만든다"
  type = list(string)
  default = ["aws16-neo", "aws16-trinity", "aws16-morpheus"]
}


resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}


output "neo_arn" {
  value = aws_iam_user.example[0].arn
  description = "네오를 위한 ARN"
}

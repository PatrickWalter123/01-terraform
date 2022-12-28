variable "server_port" {
  description = "The port the will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "instance_security_group_name" {
  type    = string
  default = "aws16-terraform.example-instance"
}

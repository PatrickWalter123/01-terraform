variable "bucket_name" {
  type    = string
  default = "aws16-terraform-state"
}

variable "table_name" {
  type    = string
  default = "aws16-terraform-locks"
}

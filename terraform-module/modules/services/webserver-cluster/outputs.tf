output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}


output "asg_name" {
  value       = "aws_autoscaling_group.example.name"
  description = "The name of the Auto Sacling Group"
}

output "alb_security _group_id" {
  value       = "aws_security_group.alb.id"
  description = "The ID of the security Group attached to the load balancer"
}

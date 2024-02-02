# modules/alb/outputs.tf

# Output the DNS name of the Application Load Balancer
output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

# Output the ARN of the target group for the ALB
output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

# Output the Zone ID of the Application Load Balancer
output "alb_zone_id" {
  value = aws_lb.app_lb.zone_id
}

# modules/ec2/outputs.tf

output "instance_ids" {
  value = aws_instance.app_server.*.id
}

output "target_group_arns" {
  value = aws_lb_target_group_attachment.tga.*.target_group_arn
}

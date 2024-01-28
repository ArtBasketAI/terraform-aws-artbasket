# outputs.tf

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.artbasket_bucket.bucket
}

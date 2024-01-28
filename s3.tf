# s3.tf

resource "aws_s3_bucket" "artbasket_bucket" {
  bucket = "artbasket-ai-frontend-20240128" # Unique bucket name

  tags = {
    Name = "ArtBasket AI Frontend Bucket"
  }
}

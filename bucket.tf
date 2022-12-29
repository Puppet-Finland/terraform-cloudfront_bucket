resource "aws_s3_bucket" "default" {
  bucket = "${var.name}-managed"
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.default.id
  versioning_configuration {
    status = "Disabled"
  }
}

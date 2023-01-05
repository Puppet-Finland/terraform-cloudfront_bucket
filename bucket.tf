resource "aws_s3_bucket" "default" {
  bucket = "${var.name}-managed"
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.id
  acl    = var.bucket_canned_acl
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.default.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.default.id
  policy = templatefile("${path.module}/bucket_policy.json.tftpl", { bucket_arn = aws_s3_bucket.default.arn, source_arn = aws_cloudfront_distribution.default.arn })
}

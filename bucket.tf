resource "aws_s3_bucket" "default" {
  bucket = "${var.name}-managed"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.default.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_policy" "default" {
  count  = var.manage_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.default.id
  policy = templatefile("${path.module}/bucket_policy.json.tftpl", { bucket_arn = aws_s3_bucket.default.arn, source_arn = aws_cloudfront_distribution.default.arn })
}

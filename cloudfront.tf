data "aws_acm_certificate" "default" {
  provider    = aws.us-east-1
  domain      = var.name
  statuses    = ["ISSUED"]
  key_types   = ["RSA_2048", "EC_prime256v1"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "default" {
  origin {
    domain_name              = aws_s3_bucket.default.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.default.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    connection_attempts      = 3
    connection_timeout       = 10
  }

  default_root_object = "index.html"
  enabled         = true
  comment         = "Console assets"
  aliases         = concat([var.name], var.aliases)
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  tags            = var.tags

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = var.cloudfront_cached_policy_managed_optimized_id
    target_origin_id       = aws_s3_bucket.default.bucket_regional_domain_name
    compress               = true
    viewer_protocol_policy = var.viewer_protocol_policy
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.default.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  lifecycle {
    ignore_changes = []
  }
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = var.name
  description                       = "Allow access to ${var.name}-managed S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

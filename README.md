# terraform-cloudfront_bucket

Create a SSL/TLS-enabled Cloudfront distribution and its origin S3 bucket in
one go. The SSL certificate is obtained from us-east-1 using a data source and
not managed by this module.

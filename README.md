# terraform-cloudfront_bucket

Create a SSL/TLS-enabled Cloudfront distribution and its origin S3 bucket in
one go. The SSL certificate is obtained from us-east-1 using a data source and
not managed by this module.

# Usage

## Parameters

The module takes only two parameters:

* *name*: used as an alias for the Cloudfront distribution. Should match the SSL certificate's domain name or SAN.
* *tags*: tags to apply to the resources (Cloudfront distribution and S3 bucket)

## SSL certificates

This module does not manage SSL certificates. You need to upload them to the us-east-1 region prior to creating
a Cloudfront distribution with this module.

## Example usage

Here's a sample of how to call the module:

```
module "firmware_cloudfront" {
  source = "github.com/Puppet-Finland/terraform-cloudfront_bucket?ref=1.0.0"
  name   = "files.example.org"
  tags   = { "Role": "File distribution" }
}
```

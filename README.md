# terraform-cloudfront_bucket

Create a SSL/TLS-enabled Cloudfront distribution and its origin S3 bucket in
one go. The SSL certificate is obtained from us-east-1 using a data source and
not managed by this module.

This module sets up an S3 bucket policy that allows the Cloudfront distribution
to read bucket contents. This allows Cloudfront to work normally even when ACLs
for the bucket *objects* would otherwise prevent it from doing so.

# Usage

## Parameters

The module takes the following parameters:

* *name*: used as an alias for the Cloudfront distribution. Should match the SSL certificate's domain name or SAN.
* *aliases*: a list of additional aliases for the Cloudfront distribution
* *bucket_canned_acl*: the "canned ACL" for the bucket. Defaults to "private". Can be one of private, public-read, public-read-write, aws-exec-read or authenticated-read. Normally you should not modify this parameter.
* *tags*: tags to apply to the resources (Cloudfront distribution and S3 bucket)
* *viewer_protocol_policy*: possible values are *allow-all*, *https-only*,  *redirect-to-https*

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

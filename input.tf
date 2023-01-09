variable "aliases" {
  type    = list
  default = []
}

variable "bucket_canned_acl" {
  type    = string
  default = "private"

  validation {
    condition     = length(regexall("^(private|public-read|public-read-write|aws-exec-read|authenticated-read)$", var.bucket_canned_acl)) > 0
    error_message = "ERROR: Invalid canned ACL!"
  }
}

variable "name" {
  type = string
}

variable "tags" {
  type    = map
  default = {}
}

variable "viewer_protocol_policy" {
  type    = string
  default = "redirect-to-https"

  validation {
    condition     = length(regexall("^(allow-all|https-only|redirect-to-https)$", var.viewer_protocol_policy)) > 0
    error_message = "ERROR: Invalid viewer protocol policy!"
  }
}

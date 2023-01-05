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

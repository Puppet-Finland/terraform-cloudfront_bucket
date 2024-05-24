variable "aliases" {
  type    = list
  default = []
}

variable "name" {
  type = string
}

variable "manage_bucket_policy" {
  type        = bool
  default     = true
  description = "Whether to manage the S3 bucket policy or not"
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

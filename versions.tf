terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
      configuration_aliases = [
        aws,
        aws.us-east-1 ]
    }
  }
}

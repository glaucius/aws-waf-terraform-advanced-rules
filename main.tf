locals {
  suffix=lower(join("-",  ["aws-waf", var.env, random_string.random_suffix.result]))
}

resource "random_string" "random_suffix" {
  length  = 4
  special = false
  upper   = false
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      env       = var.env
      region       = var.aws_region
      responsible = var.responsible
    }
  }

}

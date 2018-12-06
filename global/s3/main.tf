provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "sollab-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "sollab-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

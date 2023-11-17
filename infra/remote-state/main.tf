terraform {
  required_version = "1.6.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote_state" {
  bucket = "terraform-remote-state-${data.aws_caller_identity.current.account_id}"

  tags = {
    Owner       = data.aws_caller_identity.current.account_id
    Description = "Stores terraform remote state files"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_ownership_controls" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.remote_state]
}

resource "aws_s3_bucket_versioning" "versioning_remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote_state.id
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote_state.arn
}
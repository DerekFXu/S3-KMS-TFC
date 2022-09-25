terraform {
  required_version = "~> 1.0.11"
  required_providers {
    aws  = "~> 4.0"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "dfxbucket22" {
  bucket = "dfxbucket22"
}

resource "aws_s3_bucket_acl" "dfxbucket22-acl" {
  bucket = aws_s3_bucket.dfxbucket22.id
  acl = "private"
}

resource "aws_s3_bucket_ownership_controls" "dfxbucket22-ownership" {
  bucket = aws_s3_bucket.dfxbucket22.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
  depends_on = [
    aws_s3_bucket_acl.dfxbucket22-acl
]
}
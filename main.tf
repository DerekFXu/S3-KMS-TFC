provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "dfxbucket22" {
  bucket = "dfxbucket22"
}

resource "aws_s3_bucket_ownership_controls" "bucket_controls" {
  bucket = aws_s3_bucket.dfxbucket22.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
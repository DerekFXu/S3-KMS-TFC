provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "dfxbucket22" {
  bucket = "dfxbucket22"
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.dfxbucket22.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
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
}
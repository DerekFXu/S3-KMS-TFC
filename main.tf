provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "dfxbucket22" {
  bucket = "dfxbucket22"
    
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

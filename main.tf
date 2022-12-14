provider "aws" {
  region = var.region
}
#Creating KMS key resource
resource "aws_kms_key" "mykey" {
  deletion_window_in_days = 10
}

###Bucket creation
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

resource "aws_s3_bucket_server_side_encryption_configuration" "kms-s3-encryption" {
  bucket = aws_s3_bucket.dfxbucket22.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}
###

###User creation
resource "aws_iam_user" "s3_user" {
  name = "s3_user"
}

resource "aws_iam_access_key" "s3_user_key" {
  user    = aws_iam_user.s3_user.name
}

resource "aws_iam_user_policy" "s3_policy" {
  name = "s3_policy"
  user = aws_iam_user.s3_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:ListBucket",
        Effect = "Allow",
        Resource = "arn:aws:s3:::dfxbucket22"
      },
      {
        Action = ["s3:GetObject", "kms:Decrypt"],
        Effect = "Allow",
        Resource = ["arn:aws:s3:::dfxbucket22/HW.txt", "arn:aws:kms:us-east-2:519677535986:key/7987df2c-d500-4ffa-b380-d61c615069ad"]
        #Since it was stated that only the download should be restricted by IP, I only added this condition for download. Listing bucket objects can be done from any IP with this user.
        #However this user can still only download the HW.txt. Other objects such as Note1/2/3 are out of the access rights for this user no matter what(they exist in the bucket for you to test that).   
      }
    ]
  })
}
###
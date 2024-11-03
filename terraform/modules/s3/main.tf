terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.1.9"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
  alias = "default"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.s3_bucket
  tags          = var.tags
  force_destroy = true
  # acl           = "public-read"
#   policy        = <<EOF
# {
#   "Id": "MakePublic",
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:GetObject"
#       ], 
#       "Sid": "PublicReadGetObject",
#       "Effect": "Allow",
#       "Resource": "arn:aws:s3:::${var.s3_bucket}/*",
#       "Principal": "*"
#     }
#    ]
#   }
#   EOF

  # website {
  #   index_document = "index.html"
  # }
}
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy        = <<EOF
{
  "Id": "MakePublic",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ], 
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.s3_bucket}/*",
      "Principal": "*"
    }
   ]
  }
  EOF
}

resource "aws_s3_bucket_website_configuration" "bucket-website-config" {
  bucket = aws_s3_bucket.s3_bucket.id
  index_document {
    suffix = "index.html"
  }
  # Add other website configuration options if needed
}

resource "aws_s3_bucket_public_access_block" "access-block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.access-block]
}


# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"
  tags = var.common_tags
}

resource "aws_s3_bucket_policy" "www_bucket_policy" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = templatefile("templates/s3-policy.json", {
    bucket = aws_s3_bucket.www_bucket.id,
    domain = aws_cloudfront_distribution.www_s3_distribution.domain_name,
  })
}

# S3 bucket ACL
resource "aws_s3_bucket_acl" "www_bucket_acl" {
  bucket = aws_s3_bucket.www_bucket.id

  acl = "public-read"
}

# S3 bucket CORS configuration
resource "aws_s3_bucket_cors_configuration" "www_bucket_cors_configuration" {
  bucket = aws_s3_bucket.www_bucket.bucket

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }
}

# S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "www_bucket_website_configuration" {
  bucket = aws_s3_bucket.www_bucket.bucket

  index_document {
    suffix = "index.html"
  } 
  error_document {
    key = "404.html"
  }
}

# S3 bucket for redirecting non-www to www.
# S3 bucket for website.
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name
  tags   = var.common_tags
}

# S3 bucket ACL
resource "aws_s3_bucket_acl" "root_bucket_acl" {
  bucket = aws_s3_bucket.root_bucket.id

  acl = "public-read"
}

# S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "root_bucket_website_configuration" {
  bucket = aws_s3_bucket.root_bucket.id

  redirect_all_requests_to {
    host_name = "www.${var.domain_name}"
    protocol  = "https"
  }
}

# main.tf

# Define the provider (AWS in this case)
provider "aws" {
  region = var.aws_region
}

# Create an S3 bucket for hosting the website
resource "aws_s3_bucket" "website" {
  bucket = var.website_bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Create an S3 bucket for redirecting non-www to www
resource "aws_s3_bucket_redirect" "redirect" {
  bucket     = var.redirect_bucket_name
  host_name  = "www.${var.domain_name}"
  protocol   = "https"
}

# Create an SSL certificate using ACM (for CloudFront)
resource "aws_acm_certificate" "website_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

# Create a CloudFront distribution
resource "aws_cloudfront_distribution" "website_cdn" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.website.id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.domain_name]

  default_cache_behavior {
    target_origin_id = "S3-${aws_s3_bucket.website.id}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Additional settings (e.g., logging, custom error pages, etc.)
}

# Route 53 DNS records
resource "aws_route53_record" "website_dns" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name    = aws_cloudfront_distribution.website_cdn.domain_name
    zone_id = aws_cloudfront_distribution.website_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# Input variable definitions
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Region where s3 bucket will be created."
}

variable "aws_profile" {
  description = "Profile to use for the AWS provider."
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "Name of the S3 bucket. Must be Unique across AWS"
  type        = string
}

variable "tags" {
  description = "Tages to set on the bucket"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "domain name (or application name if no domain name available)"
}

variable "cloudfront_min_ttl" {
  default     = 0
  description = "The minimum TTL for the cloudfront cache"
}

variable "cloudfront_default_ttl" {
  default     = 86400
  description = "The default TTL for the cloudfront cache"
}

variable "cloudfront_max_ttl" {
  default     = 31536000
  description = "The maximum TTL for the cloudfront cache"
}

variable "cloudfront_geo_restriction_restriction_type" {
  default     = "none"
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  validation {
    error_message = "Can only specify either none, whitelist, blacklist"
    condition     = can(regex("^(none|whitelist|blacklist)$", var.cloudfront_geo_restriction_restriction_type))
  }

}

variable "cloudfront_geo_restriction_locations" {
  default     = []
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  validation {
    error_message = "must be a valid ISO 3166-1-alpha-2 code"
    condition     = length(var.cloudfront_geo_restriction_locations) == 2
  }

}

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
  default     = ""
}

variable "tags" {
  description = "Tags to set on the bucket"
  type        = map(string)
  default     = {}
}

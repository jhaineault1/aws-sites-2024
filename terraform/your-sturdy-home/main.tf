provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

module "yoursturdyhome_s3" {
  source      = "../modules/s3"
  aws_region  = "us-east-1"
  aws_profile = "jeff-tf"
  s3_bucket   = "www.yoursturdyhome.com"
}

module "yoursturdyhome_route53" {
  source      = "../modules/route53"
  zone_id     = "www.yoursturdyhome.com"
  domain_name = "www.yoursturdyhome.com"
  ip_address  = "10.10.200.1"
}

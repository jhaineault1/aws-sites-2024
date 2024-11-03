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

resource "aws_route53_zone" "zone" {
  name    = var.domain_name
  comment = "hosted zone"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = "300"

  records = [var.ip_address]
}

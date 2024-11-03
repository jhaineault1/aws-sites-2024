terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket     = "tfstate-jh-sites"
    key        = "your_sturdy_home"
    region     = "us-east-1"
    encrypt    = true
    kms_key_id = "alias/terraform-bucket-key"
  }
}

terraform {
  backend "s3" {
    bucket                = "tfstate-sites"
    key                   = "yoursturdyhome"
    region                = "us-east-1"
    encrypt               = true
    dynamodb_table        = "tf-state-lock"
  }
}

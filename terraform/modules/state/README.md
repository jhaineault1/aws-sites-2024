# Terraform State Dev

This contains the configuration for the remote backend resources for the dev environment,

## Using the remote state

To use these remote state files, simply copy the state.tf file to the root of your terraform repo and run `terraform init`.

## Gotchas

- The provided state.tf file declares an AWS provider. Be cautious about declaring conflicting aws providers as this might result in unexpected behaviour.
- This repo does not configure authentication for AWS. The S3 bucket is private and encrypted, so to use this state you must be authenticated to your AWS account. To use this state to manage resources on another AWS Account there will need to be some modifications.

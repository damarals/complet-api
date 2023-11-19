locals {
  aws_account_id = "027075156904"
  aws_region     = "us-east-1"
  env            = terraform.workspace == "default" ? "dev" : terraform.workspace
}
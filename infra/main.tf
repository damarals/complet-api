terraform {
  required_version = "1.6.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }

  backend "s3" {
    bucket = "terraform-remote-state-027075156904"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = local.aws_region
}

module "lambda_stack" {
  source = "./stack"

  local_dir_to_build = "../app"
  aws_account_id     = local.aws_account_id

  project_name = "complet" # Complet is the name of the project

  env = local.env
}
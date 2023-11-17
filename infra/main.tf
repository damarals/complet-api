terraform {
  required_version = "1.6.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

module "lambda_stack" {
  source = "./stack"

  local_dir_to_build = "../app"
  docker_file_name   = "Dockerfile.prod"
  aws_account_id     = "027075156904"

  local_image_name  = "lambda_api"
  aws_function_name = "lambda_api"

  stage                                = var.stage
  lambda_runtime_environment_variables = var.lambda_runtime_environment_variables
}
module "lambda_function" {
  source = "./lambda_api"

  local_dir_to_build = "../app"
  docker_file_name   = "Dockerfile.prod"
  aws_account_id     = "027075156904"
  aws_region         = "us-east-1"

  local_image_name         = "lambda_api"
  aws_function_name        = "apifunctionlambda"
  aws_function_description = "FastAPI lambda Rest API"
  api_name                 = "completapi"
  api_stage                = "dev"

  lambda_runtime_environment_variables = {
    API_STAGE = "dev"
  }
}

output "base_url" {
  value = module.lambda_function.base_url
}
locals {
  aws_region                           = "us-east-1"
  worker_so                            = lookup(var.worker_so, var.env)
  docker_file_name                     = lookup(var.docker_file_name, var.env)
  version                              = sha1(join("", [for f in fileset("${var.local_dir_to_build}", "**") : filesha1("${var.local_dir_to_build}/${f}")]))
  image_name                           = "lambda_api_image"
  lambda_runtime_environment_variables = merge(lookup(var.lambda_runtime_environment_variables, var.env), { API_VERSION = var.api_version })
}
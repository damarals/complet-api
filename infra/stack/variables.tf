variable "local_image_name" {
  description = "The name of the local docker image that will be build."
  type        = string
}

variable "aws_function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "local_dir_to_build" {
  description = "The path to the local directory that needs to get build."
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID to use."
  type        = string
}

variable "stage" {
  description = "The stage to use when deploying the API gateway resources."
  type        = string
  default     = "staging"
}

variable "docker_file_name" {
  description = "The name of the local Dockerfile to build."
  type        = string
  default     = "Dockerfile"
}

variable "lambda_runtime_environment_variables" {
  description = "The runtime environment variables to include in the Lambda"
  type        = map(any)
  default = {
    API_STAGE = "staging"
  }
}

variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "us-east-1"
  type        = string
}
variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS profile to use to execute the commands"
  type        = string
  default     = "default"
}

variable "stage" {
  description = "The stage to use when deploying the aws resources."
  type        = string
  default     = "local"
}

variable "lambda_runtime_environment_variables" {
  description = "The runtime environment variables to include in the Lambda"
  type        = map(any)
  default = {
    API_STAGE = "local"
  }
}

variable "worker_so" {
  description = "The worker operating system."
  type        = string
  default     = "windows"
}
variable "stage" {
  description = "The stage to use when deploying the aws resources."
  type        = string
  default     = "staging"
}

variable "lambda_runtime_environment_variables" {
  description = "The runtime environment variables to include in the Lambda"
  type        = map(any)
  default = {
    API_STAGE = "staging"
  }
}
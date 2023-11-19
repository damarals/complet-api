variable "project_name" {
  description = "The name of the project."
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

variable "env" {
  description = "The environment to use when deploying the API gateway resources."
  type        = string
  default     = "dev"
}

variable "docker_file_name" {
  description = "The name of the local Dockerfile to build."
  type = object({
    dev     = string
    staging = string
    prod    = string
  })
  default = {
    dev     = "Dockerfile", # Dockerfile is used for local development
    staging = "Dockerfile.prod"
    prod    = "Dockerfile.prod"
  }
}

variable "lambda_runtime_environment_variables" {
  description = "The runtime environment variables to include in the Lambda"
  type = object({
    dev     = map(string)
    staging = map(string)
    prod    = map(string)
  })
  default = {
    dev = {
      API_ENV = "dev"
    },
    staging = {
      API_ENV = "staging"
    },
    prod = {
      API_ENV = "prod"
    }
  }
}

variable "worker_so" {
  description = "The worker operating system."
  type = object({
    dev     = string
    staging = string
    prod    = string
  })
  default = {
    dev     = "windows",
    staging = "linux",
    prod    = "linux"
  }
}
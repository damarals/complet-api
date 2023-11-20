data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.project_name}_lambda_function_role_${var.env}"
  description        = "Lambda function role for ${var.project_name} project at ${var.env} environment"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
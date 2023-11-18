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
  name               = "${local.resource_name_prefix}_lambda_function_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
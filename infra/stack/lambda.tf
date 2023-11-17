resource "aws_lambda_function" "this" {
  function_name = "${local.resource_name_prefix}_${var.aws_function_name}"
  description   = "Lambda function for ${var.aws_function_name} in ${var.stage} environment"
  image_uri     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${aws_ecr_repository.this.name}:${local.version}"
  package_type  = "Image"
  role          = aws_iam_role.this.arn
  timeout       = 30

  environment {
    variables = var.lambda_runtime_environment_variables
  }

  depends_on = [
    null_resource.ecr_image,
    aws_ecr_repository.this,
    aws_iam_role.this
  ]
}

resource "aws_lambda_permission" "apigw" {
  function_name = aws_lambda_function.this.function_name
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}